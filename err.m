function [tell sparse_approx_img index] = err(image, Dictionaries, lambda, completedTsets)

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

err = [];
image_vec_norm = norm(image_vec);

for i = 1:completedTsets,
    D = Dictionaries{i};
    a = alphas{i}
    % error
    im = D*a;
    im = 255*mat2gray(im); %conversion
    err(i)= norm(im-image_vec)/image_vec_norm
end

index = find(min(err) == err);
tell = alphabet(index);
sparse_approx_img = convert_vector_to_image(Dictionaries{index}*alphas{index}, 20);

end