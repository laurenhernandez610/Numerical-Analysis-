% GAUSSIAN ELIMINATION WITH BACKWARD SUBSTITUTION ALGOTITHM 6.1
%
% To solve the n by n linear system
%
% E1:  A(1,1) X(1) + A(1,2) X(2) +...+ A(1,n) X(n) = A(1,n+1)
% E2:  A(2,1) X(1) + A(2,2) X(2) +...+ A(2,n) X(n) = A(2,n+1)
% :
% .
% EN:  A(n,1) X(1) + A(n,2) X(2) +...+ A(n,n) X(n) = A(n,n+1)
%
% INPUT:   number of unknowns and equations n; augmented
%          matrix A = (A(I,J)) where 1<=I<=n and 1<=J<=n+1.
%
% OUTPUT:  solution x(1), x(2),...,x(n) or a message that the
%          linear system has no unique solution.
%   syms('AA', 'NAME', 'INP', 'OK', 'N', 'I', 'J', 'A', 'NN', 'M');
%   syms('ICHG', 'IP', 'JJ', 'C', 'XM', 'K', 'X', 'SUM');
%   syms('KK', 'FLAG', 'OUP');
 TRUE = 1;
 FALSE = 0;
 fprintf(1,'This is Cramer rule to solve a linear system.\n');
 fprintf(1,'The array and right-hand-side shall be written in the code in advance.\n');
 fprintf(1,'Have the array and right-hand-side been given? - enter Y or N.\n');
 AA = input(' ','s');
 OK = FALSE;
 if AA == 'Y' | AA == 'y' 
 while OK == FALSE
% Matrix dimension N
% N<738; N=738:det(A)=inf for A=diag(3,3,3,3,...,3);
 N=????; % N<4000; N=4000:det(A)=inf for A=diag(2.1,2.1,2.1,2.1,...,2.1) <-----------------
 
 A = zeros(N,N); 
 B = zeros(N,N);

 X = zeros(1,N);
 b = zeros(1,N);
 for I = 1:N
 for J = 1:N
   if I==J,
    A(I,J) =????;
   end;
   if J==I+1,
    A(I,J)=????;
   end;
   if J==I-1,
    A(I,J)=????;
   end; 
      
 end;
 end;
% right-hand-side
   b(1)=????;
   for I = 2:N-1
    b(I)=????;
   end;
   b(N)=????;
   
 OK = TRUE;
 end;
 else 
 fprintf(1,'The program will end so the matrix can be written.\n');
 end;

 if OK == TRUE 
 
 fprintf(1,'The code is executing now.\n');

 t = cputime; %Starting time
  
 format long;
 [z,z]=size(A);
 DD=det(A)
 for i=1:z;
   B=A;
   B(:,i)=b;
   X(i)=det(B)/det(A);
 end;
 
 eltime = cputime-t; %total elapse time
 
% STEP 10
% procedure completed successfully
 fprintf(1,'Choice of output method:\n');
 fprintf(1,'1. Output to screen\n');
 fprintf(1,'2. Output to text file\n');
 fprintf(1,'Please enter 1 or 2.\n');
 FLAG = input(' ');
 if FLAG == 2 
 fprintf(1,'Input the file name in the form - drive:\\name.ext\n');
 fprintf(1,'for example:  A:\\OUTPUT.DTA\n');
 NAME = input(' ','s');
 OUP = fopen(NAME,'wt');
 else
 OUP = 1;
 end;
 fprintf(OUP, 'GAUSSIAN ELIMINATION\n\n');
%  fprintf(OUP, 'The reduced system - output by rows:\n');
%   for I = 1:N
%   for J = 1:M
%   fprintf(OUP, ' %11.8f', A(I,J));
%   end;
%   fprintf(OUP, '\n');
%   end;
 
 ERRMAX=0.0;
 for I=1:N
    TMP=abs(X(I)-????);
    if TMP > ERRMAX
       ERRMAX=TMP;
    end; 
 end; 
fprintf(OUP, 'MAX ERROR=  %12.8e\n', ERRMAX);
 
  
 if ERRMAX<0.00001,
 fprintf(OUP, 'cpu time is \n'); 
 fprintf(OUP, '%12.8e\n',eltime);
 else
  fprintf(OUP, 'Something is wrong. \n');    
 end;  
 
 if OUP ~= 1 
 fclose(OUP);
 fprintf(1,'Output file %s created successfully \n',NAME);
 end;
 end;
 
 if OK == FALSE 
 fprintf(1,'System has no unique solution\n');
 end;
  
