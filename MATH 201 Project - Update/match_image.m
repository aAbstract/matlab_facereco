function out = match_image(image_data)
% MATCH_IMAGE this function return best match of the
% given image from the data base
img_vector = reshape(image_data,120*80,1);
data = xlsread('./train_res.xlsx');
mean_face = data(:,size(data,2));
if_vector = double(img_vector) - mean_face;
projected_face = data(:,1 : size(data,2) - 1)' * if_vector;
data_set = xlsread('./data_set.xlsx');
distances = [];
for i = 1 : size(data_set,2)
    temp = (norm(projected_face - data_set(:,i)))^2;
    distances = [distances temp];
end
[e,i] = min(distances);
disp(strcat("ERROR: ",string(e)));
all_data = dir('./db');
rec_img = all_data(i + 2);
%imshow(strcat('./db/',rec_img.name));
name = regexp(rec_img.name,"[a-z]+\.",'match');
msgbox(strcat("HI: ",name));
out = i;
end

