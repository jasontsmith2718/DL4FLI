function irf = irf_smooth(irf0)
%IRF_SMOOTH Summary of this function goes here
%   Detailed explanation goes here
    offset = max(irf0(end-100:end));
    irf = irf0 - offset;
    irf(irf<0) = 0;
end

