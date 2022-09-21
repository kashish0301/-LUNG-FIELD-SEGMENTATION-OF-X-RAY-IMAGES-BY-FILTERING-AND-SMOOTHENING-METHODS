function y =acf(Im0,VecParameters);
maxI = 256; % max image intensity
MODEL_SMOOTH_IMAGE=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process input image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Ny,Nx] = size(Im0); 
Im0 = double(Im0);
Im0 = Im0/ max(Im0(:)); % Intensity range = [0 1]
Im0 = 1 + maxI* Im0;    % Intensity range = [1 maxI]
Im0Ref = Im0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute edge detector function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
use_edge_detector = 2;
if use_edge_detector == 1    
    std_Gb = 1;
    beta = 50/maxI^2;
    % Smooth input image
    Ng=ceil(6*std_Gb)+1; Gaussian = fspecial('gaussian',[Ny Nx],std_Gb);
    Im0s = ifftshift( ifft2( fft2(Im0) .* fft2(Gaussian) ) );
    % Norm of the gradient of the smoothed image
    [Gx,Gy] = gradient(Im0s);
    NormGrad = sqrt(Gx.^2 + Gy.^2);
    % Edge detector function
    Gb = ones(size(Im0))./ (1 + beta* NormGrad.^2);
    figure(cpt_fig); imagesc(Gb); colormap(gray); title('The stopping function'); colorbar;
    cpt_fig = cpt_fig + 1; 
else
    Gb = ones(Ny,Nx);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Segmentation code in mex/c
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mex function
ModelSeg = VecParameters(3);
if ModelSeg == MODEL_SMOOTH_IMAGE
    [u,MeanIn,MeanOut] = active_contour_minimization_mex(single(Im0),single(Gb),single(VecParameters));
    FT = Im0;
elseif ModelSeg == MODEL_TEXTURE_IMAGE
    [u,pIn,pOut,FT] = active_contour_minimization_mex(single(Im0),single(Gb),single(VecParameters));
    % FT: Texture Feature
end
u = double(u); 
% Display result
if ModelSeg ==MODEL_SMOOTH_IMAGE    
    disp('Final Inside Mean and Outside Mean:');
    MeanIn
    MeanOut
    subplot(236); imshow(uint8(Im0Ref)); title('Segmentation');
    hold on; [c,h] = contour(u,[0.5 0.5],'r-'); set(h,'LineWidth',2);   
 F=getframe;
    y=F.cdata;;
% elseif ModelSeg == MODEL_TEXTURE_IMAGE
%     figure(cpt_fig); clf;
%     subplot(321); imagesc(Im0Ref); title('Image'); colormap(gray); colorbar; axis off;
%     subplot(323); title({'Final Inside Intensity Distribution (Red plot)','Final Outside Intensity Distribution (Blue plot)'})
%     hold on; colormap(gray); colorbar; axis on;
%     X = 1:maxI+1; plot(X,pIn,'r'); plot(X,pOut,'b');
%     subplot(322); imagesc(FT); title('Texture Feature'); colormap(gray); colorbar; axis off;
%     subplot(324); imagesc(Im0Ref); title('Segmentation'); colormap(gray); colorbar; axis off;
%     hold on; [c,h] = contour(u,[0.5 0.5],'m-'); set(h,'LineWidth',2);
%     subplot(325); imagesc(u); title('u'); colormap(gray); colorbar; axis off;
%     subplot(326); imagesc(u>0.5); title('Thresholded u (u>0.5)'); colormap(gray); colorbar; axis off;
%     sI=3; truesize(cpt_fig,[round(sI*Ny) round(sI*Nx)]);
end