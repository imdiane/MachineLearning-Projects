load ('/Users/apple/Desktop/DataSets/CSE847HW/HW5/USPS.mat');

% Apply PCA to the data using p = 10; 50; 100; 200.

P=[10 50 100 200];
nComp = length(P);

mu = mean(A);
A = A - ones(length(A),1) * mu;

R = A' * A ;
[U, M] = eig(R) ;

% Reconstruction error for p = 10; 50; 100; 200.

error= zeros([1,nComp]);
B = cell(nComp,1);

for n= 1: nComp
    B(n)={U(:, end-P(n)+1:end)};
    error(n) = norm(A-A*B{n}*B{n}','fro')^2;
end

% Images reconstruction.

nImage = 2;

for m = 1 : nImage  
    
    for n = 1 : nComp
        R_A2 = reshape(A(m,:)*B{n}*B{n}'+ mu, 16, 16) ;
        subplot(nImage, nComp + 1,(m-1) * (nComp + 1) + n ), imshow(R_A2')
    end
    
    A2 = reshape(A(m,:)+ mu, 16, 16); 
    subplot(nImage, nComp+1,m * (nComp + 1) ), imshow(A2')
end

