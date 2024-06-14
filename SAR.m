% Read and process the image
image = imread('SAR.png'); 

% Apply logarithmic transformation
log_image = log(double(image) + 1);

% Wavelet decomposition
j = 2; 
we = 'db1'; 
[C, S] = wavedec2(log_image, j, we);

% Extract diagonal subband coefficients at level j
[H, V, D] = detcoef2('all', C, S, j);
diagonal_subband = -D;

% Display the histogram of the diagonal subband coefficient

% Fit Gaussian and Generalized Gaussian distributions
pd_gaussian = fitdist(diagonal_subband(:), 'Normal');
pd_ggd = fitdist(diagonal_subband(:), 'GeneralizedExtremeValue');

% Display the PDF of the wavelet coefficients and the fitted distributions
figure;
histogram(diagonal_subband, 'Normalization', 'pdf');
hold on;

% Define the range of x values for plotting the PDFs
x_values = min(diagonal_subband(:)):0.01:max(diagonal_subband(:));

% Plot the Gaussian PDF
plot(x_values, pdf(pd_gaussian, x_values), 'LineStyle','--');
hold on;

% Plot the Generalized Gaussian PDF
plot(x_values, pdf(pd_ggd, x_values), '-.');
title('Fitted Distributions on Wavelet Coefficients');
xlabel('Coefficient Value');
ylabel('Probability Density');
legend('Wavelet Coefficients', 'Gaussian Fit', 'Generalized Gaussian Fit');

% Display the images
figure;
subplot(1, 2, 1);
imshow(image, []);
title('Original Image');

subplot(1, 2, 2);
imshow(log_image, []);
title('Log Transformed Image');

