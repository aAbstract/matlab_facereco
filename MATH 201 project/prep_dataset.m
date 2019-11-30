function prep_dataset(acc)
% This Function Reads The Available Database And Compute The Eigenvectors
% , Eigenvalues and The Mean Face
image_dirs = dir('./db');
image_vectors = [];
for i = 1:size(image_dirs,1)
    if(~strcmp(image_dirs(i).name,'.') && ~strcmp(image_dirs(i).name,'..'))
        img = imread(strcat('./db/',image_dirs(i).name));
        img = rgb2gray(img);
        img = imresize(img,[120 80]);
        imshow(img)
        img_vector = reshape(img,120 * 80,1);
        image_vectors = [image_vectors img_vector];
    end
end
mean_face = mean(image_vectors,2);
%pcolor(flipud(reshape(mean_face,120,80))), shading interp, colormap(gray)
if_vectors = [];
for i = 1 : size(image_vectors,2)
    temp = double(image_vectors(:,i)) - mean_face;
    if_vectors = [if_vectors temp];
end
co_mat = if_vectors' * if_vectors;
[eigen_vectors,eigen_values] = eigs(co_mat);
curren_acc = 0;
net_eigen_vectors = [];
sum_of_eigen_values = sum(sum(abs(eigen_values)));
for i = 1 : size(eigen_vectors,2)
    contr = (eigen_values(i,i)) / (sum_of_eigen_values);
    current_acc = curren_acc + contr;
    net_eigen_vectors = [net_eigen_vectors eigen_vectors(:,i)];
    if(current_acc >= acc)
        break
    else
        continue
    end
end
eigen_faces = if_vectors * net_eigen_vectors;
output = [eigen_faces mean_face];
figure(1)
for i = 1:size(eigen_faces,2)
    subplot(1,size(eigen_faces,2),i), pcolor(flipud(reshape(eigen_faces(:,i),120,80))),shading interp, colormap(gray);
end
xlswrite('./train_res.xlsx',output);
projected_img = [];
z = eigen_faces;
p_m = (z * (z' * z) * z');
for i = 1 : size(if_vectors,2)
    temp = z' * if_vectors(:,i);
    projected_img = [projected_img temp];
end
xlswrite('./data_set.xlsx',projected_img);
end

