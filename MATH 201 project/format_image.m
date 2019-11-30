function output = format_image(input)
i = rgb2gray(input);
i = imresize(i, [120 80]);
output = i;
end

