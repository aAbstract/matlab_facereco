function recon(image_data)
%RECON Summary of this functoin shows how the projected face looks like
img_vector = reshape(image_data,120*80,1);
data = xlsread('./train_res.xlsx');
mean_face = data(:,size(data,2));
if_vector = double(img_vector) - mean_face;
projected_face = data(:,1 : size(data,2) - 1)' * if_vector;
fake_image = zeros(9600,1);
x = data(:,1 : size(data,2) - 1);
for i = 1:size(x,2)
    fake_image = fake_image + (x(:,i) * projected_face(i));
end
subplot(1,5,1), imshow(image_data);
subplot(1,5,2), pcolor(flipud(reshape(mean_face,120,80))),shading interp, colormap(gray);
subplot(1,5,3), imshow(reshape(fake_image,120,80));
subplot(1,5,4), pcolor(flipud(reshape(fake_image,120,80))),shading interp, colormap(gray);
subplot(1,5,5), pcolor(flipud(reshape((mean_face + fake_image),120,80))),shading interp, colormap(gray);
end

