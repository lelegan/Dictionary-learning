noteOfInterest = imread('http://www.mathworks.com/matlabcentral/answers/uploaded_files/6835/corchea.jpg');
noteOfInterest = rgb2gray(noteOfInterest);

C1 = normxcorr2(noteOfInterest,noteOfInterest);
max(C1(:))

aDifferentNoteFromLibrary = imread('http://www.mathworks.com/matlabcentral/answers/uploaded_files/6833/fusa.jpg');
aDifferentNoteFromLibrary = rgb2gray(aDifferentNoteFromLibrary);
C2 = normxcorr2(noteOfInterest,aDifferentNoteFromLibrary);
max(C2(:))

imshow(aDifferentNoteFromLibrary)


figure, surf(C1), shading flat
figure, surf(C2), shading flat