% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Useful for debugging, visualization or other purposes post-generation of
% a simulation TPSF voxel.
% 
% Jason T. Smith, Rensselaer Polytechnic Institute, August 22, 2019
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%% Plot a specific TPSF and display the parameters used for generation in the command-window.
xC = 12;
yC = 12;
figure;
plot(squeeze(sigD(yC,xC,:)));
display(['Intensity:' num2str(I(yC,xC))]);
display(['Tau1:' num2str(t1(yC,xC))])
display(['Tau2:' num2str(t2(yC,xC))])
display(['A1:' num2str(rT(yC,xC))])

% Plot all TPSFs from non-zero pixels for display.
figure;
for i = 1:28
    for j = 1:28
        cS = squeeze(sigD(i,j,:));
        if sum(cS) == 0
            continue
        end
        hold on;
        plot(cS)
    end
end
        