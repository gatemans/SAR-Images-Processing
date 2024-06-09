image = imread('SAR.png'); 
image = rgb2gray(image); 

log_image = log(double(image) + 1);

j = 2; 
we = 'db1'; 
[C, S] = wavedec2(log_image, j, we);

[H, V, D] = detcoef2('all', C, S, j);
diagonal_subband = -D;

figure;
histogram(diagonal_subband);
title('Histogram of the wavelet coefficients in the diagonal subband at the second level of decomposition');
xlabel('Coefficient Value');
ylabel('Frequency');
pd_gaussian = fitdist(diagonal_subband(:), 'Normal');

pd_ggd = fitdist(diagonal_subband(:), 'GeneralizedExtremeValue');

histogram(diagonal_subband, 'Normalization', 'pdf');

hold on;
x_values = -2:0.01:2;
plot(x_values, pdf(pd_gaussian, x_values), 'LineStyle','--');
title('Gaussian Fit');
xlabel('Coefficient Value');
ylabel('Probability Density');

hold on;
plot(x_values, pdf(pd_ggd, x_values), '-.');
title('Generalized Gaussian Fit');
xlabel('Coefficient Value');
ylabel('Probability Density');

legend('Wavelet Coefficients', 'Gaussian Fit', 'Generalized Gaussian Fit');

