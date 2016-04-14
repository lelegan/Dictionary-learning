function [tell sparse_approx_img] = readANDtell(image, Dictionaries, lambda, completedTsets)

% image: any image; we presume it is in grey scale
% Dictionaries: our trained dictionaries
% lambda: for lars
% completeTset: number of our completed training sets

% tell (char): return the alphabet that dictionary learning think is correct
% sparse_approx_img: the image generated using the trained dictionary

% alphas: lars co-efficients
% different coefficients generated using different dictionaries

alphas = {};
image_vec = convert_image_to_vector(image);

for i = 1:completedTsets,
a = lars(Dictionaries{i}, image_vec, lambda);
a = a(size(a,1),:)';
alphas{i} = a;
end

alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

% apply correlation by max(c(:))
mc = [];

for i = 1:completedTsets,
    D = Dictionaries{i};
    a = alphas{i}
    sparse_approx = D*a;
    sparse_approx = convert_vector_to_image(sparse_approx, 20); % 20, cuz image is 20 x 20
    % correlation
    c = normxcorr2(image, sparse_approx);
    c = max(c(:));
    mc = [mc c];
end

index = find(max(mc) == mc);
tell = alphabet(index);
sparse_approx_img = convert_vector_to_image(Dictionaries{index}*alphas{index}, 20);

end