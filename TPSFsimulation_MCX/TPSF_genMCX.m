% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% THIS IS A WORK IN PROGRESS, VALIDATION STUDIES WILL BE CITED AS THEY ARE
% PERFORMED.
%
% This script is part of ongoing work aiming to utilize Monte-Carlo (via Monte-
% Carlo eXtreme [MCX] 'http://mcx.space/wiki/index.cgi?Home' ) 
% for accurate modeling of fluorescent temporal point-spread functions travelling 
% through homogenous turbid media.
%
% A TUTORIAL OF MCX IS OUTSIDE OF THE SCOPE OF THIS MATERIAL. THE
% DOCUMENTATION PROVIDED AT 'http://mcx.space/wiki/index.cgi?Doc' ALONG
% WITH RUNNING THROUGH THE EXAMPLE SCRIPT WILL HELP A GREAT DEAL FOR THOSE
% WHO ARE INTERESTED.
% 
% Jason T. Smith, Summer 2019
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

%% Add the two paths below after downloading MCX.
% addpath('...\win64\MCXStudio\MATLAB\mcxlab')
% addpath('...\win64\MCXStudio\MCXSuite\mcx\utils')


%% MNIST data will be used again for variable assignment
load train_binary;
% The IRF given were collected with our gated-ICCD.
load irf_w;
total = 1000;
nTG = 175;
k = 1;
while k <= total
    
    clear cfg;
    %%
    % Grab random binary image
    im_binary = train_images(:,:,round(rand()*size(train_images,3)));
    % If it is too sparse, start the loop again and grab another.
    if sum(sum(im_binary)) < 250
        continue
    end
    % 'cfg' is the struct that will contain all information needed for
    % Monte-Carlo simulation.
    cfg.nphoton=5e4;
    cfg.vol=uint8(ones(60,60,60)); % Define volume size
    cfg.srcdir=[0 0 1];
    cfg.gpuid=1;
    cfg.autopilot=1;
%     cfg.unitinmm = ; % If one is interested in obtaining sub-mm voxels.
    
    %% Assign OP
    us = rand().*4.5 + .5; % mu_s = [.5, 5]
    ua = rand().*.025 + .005; % mu_a = [5e-3,2.5e-2]
    depth = round(rand()*8 + 2); % z = [2,10]
    
    cfg.srcpos=[15 15 60-depth]; % Assign MNIST figure location along z
    usIm = ones(size(im_binary)).*us; % Homogenous phantom assumed
    uaIm = ones(size(im_binary)).*ua; % Homogenous phantom assumed
    
    % Preallocate memory for dual OP assignment 'OPs'.
    OPs = zeros([size(im_binary) 2]); 
    OPs(:,:,1) = usIm;
    OPs(:,:,2) = uaIm;
    % Masking of OPs
    OPm = OPs.*im_binary;
    % Assigning depth to each non-zero MNIST pixel (for potential use only,
    % not necessary).
    zIm = im_binary.*depth;
    
    % Check out the MCX documentation for more information. Anisotropy is
    % assumed to be constant (g = 0.9)
    cfg.prop=[0 0 1 1;ua us 0.9 1.37];
    
    cfg.tstart=0; % Start time
    cfg.tend=7e-9; % End time (must change to mimic apparatus of interest)
    cfg.tstep=4e-11; % Time-step (must change to mimic apparatus of interest)
    cfg.seed=99999;
    % 'srctype' is explained more in depth in MCX documentation.
    cfg.srctype='pattern'; 
    % Setting the MNIST binary digit as a fluorescent source inside of the
    % homogenous volume.
    cfg.srcpattern = im_binary;
    cfg.srcparam1=[32 0 0 32];
    cfg.srcparam2=[0 32 0 32];
    
    % Run MCX
    flux=mcxlab(cfg);

    % Mono-exponential example
    funR = inline('K.*exp(-p/Tf)','K','Tf','p');
    
    % Obtain region around MNIST figure embedding.
    tpsfC = flux.data(15:46,15:46,:,:);
    % Obtain metric used for imminent intensity assignment
    Ir = max(sum(tpsfC,4),[],3);
    % Pre-allocate memory
    tpsfs = zeros([32 32 175]);
    % Assign lifetimes at random to each non-zero pixel (t = [0.5,1] ns)
    tR = (rand(size(Ir)).*.5 + .5).*im_binary;
    for i = 1:32
        for j = 1:32
            if tR(i,j) == 0
                continue
            end
            % Obtain random IRF (from system of interest)
            irf = irf_smooth(irf_whole(:,round(rand()*10000+1)));
            % Mono-exponential decay)
            cS = funR(1,tR(i,j),(1:175).*4e-2);
            % Green's function from prior Monte-Carlo
            greenC = squeeze(tpsfC(i,j,60,:)).*cfg.tstep;
            % Sequence of signal convolutions.
            cS = conv(greenC,cS);
            cS = conv(cS,greenC);
            cS = conv(cS,irf./sum(irf));
            % Introducing laser-jitter at random for model robustness.
            r = rand();
            if r > .75
                cS = cS(1:nTG);
            elseif r < .25
                rC = round(rand().*3);
                cS = [zeros(1,rC) cS(1:nTG-rC)];
            else
                rC = round(rand().*3);
                cS = cS(1+rC:nTG+rC);
            end
            
            cS = poissrnd(cS.*Ir(i,j)); % Assign Poisson noise
            tpsfs(i,j,:) = cS./max(cS); % Max-normalize
        end
    end
    % For now, the signals outside of fluorescent region are masked.
    tpsfM = tpsfs.*im_binary;
    if k >=0 && k < 10
        n = ['0000' num2str(k)];
    elseif k >=10 && k<100
        n = ['000' num2str(k)];
    elseif k >=100 && k<1000
        n = ['00' num2str(k)];
    elseif k >=1000 && k<10000
        n = ['0' num2str(k)];
    else
        n = num2str(k);
    end
    k = k+1;
       
% Assign path along with file name.
    pathN = '';
    filenm = [pathN '\' 'a_' n '_' num2str(1)];

% Save .mat file. It is important to note the end '-v7.3' - this is one
% of the more convenient ways to facillitate easy python upload of 
% matlab-created data.
    save(filenm, 'tpsfM', 'OPm', 'zIm', 'tR', 'Ir', '-v7.3');

end

%% Check out decays generated during workflow
% figure;
% for i = 1:size(Ir,1)
%     for j = 1:size(Ir,2)
%         if tR(i,j)==0
%             continue
%         end
%         cS = squeeze(tpsfsM(i,j,:));
%         hold on;
%         plot(cS)
%     end
% end