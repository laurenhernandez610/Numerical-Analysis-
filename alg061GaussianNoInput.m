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
 fprintf(1,'This is Gaussian Elimination to solve a linear system.\n');
 fprintf(1,'The array and right-hand-side shall be written in the code in advance.\n');
 fprintf(1,'Have the array and right-hand-side been given? - enter Y or N.\n');
 AA = input(' ','s');
 OK = FALSE;
 if AA == 'Y' | AA == 'y' 
 while OK == FALSE
% Matrix dimension N
 N=????;
 
 A = zeros(N,N+1);
 X = zeros(1,N);
 for I = 1:N
 for J = 1:N
   if I==J,
    A(I,J) =????; %A(1,1), A(2,2), ..., A(N,N) entries
   end;
   if J==I+1,
    A(I,J)=????; %A(1,2), A(2,3), ..., A(N-1,N) entries
   end;
   if J==I-1,
    A(I,J)=????; %A(2,1), A(3,2), ..., A(N,N-1) entries
   end; 
 end;
 end;
 
% right-hand-side B(I)
   A(1,N+1)=????;  %B(1)
   for I = 2:N-1
    A(I,N+1)=????; %B(I)
   end;
   A(N,N+1)=????;  %B(N)
   
 OK = TRUE;
 end;
 else 
 fprintf(1,'The program will end so the matrix can be written.\n');
 end;

 if OK == TRUE 
 
 fprintf(1,'The code is executing now.\n');

 t = cputime; %Starting time
 
% STEP 1
% Elimination Process 
 NN = N-1;
 M = N+1;
 ICHG = 0;
 I = 1;
 while OK == TRUE & I <= NN 
% STEP 2
% use IP instead of p
 IP = I;
 while abs(A(IP,I)) <= 1.0e-20 & IP <= N 
 IP = IP+1;
 end;
 if IP == M 
 OK = FALSE;
 else
% STEP 3
 if IP ~= I 
 for JJ = 1:M
 C = A(I,JJ);
 A(I,JJ) = A(IP,JJ);
 A(IP,JJ) = C;
 end;
 ICHG = ICHG+1;
 end;
% STEP 4
 JJ = I+1;
 for J = JJ:N
% STEP 5
% use XM in place of m(J,I)
 XM = A(J,I)/A(I,I);
% STEP 6
 for K = JJ:M
 A(J,K) = A(J,K) - XM * A(I,K);
 end;
% Multiplier XM could be saved in A(J,I).
 A(J,I) = 0;
 end;
 end;
 I = I+1;
 end;
 if OK == TRUE
% STEP 7
 if abs(A(N,N)) <= 1.0e-20 
 OK = FALSE;
 else
% STEP 8
% start backward substitution
 X(N) = A(N,M) / A(N,N);
% STEP 9
 for K = 1:NN
 I = NN-K+1;
 JJ = I+1;
 SUM = 0;
 for KK = JJ:N
 SUM = SUM - A(I,KK) * X(KK);
 end;
 X(I) = (A(I,M)+SUM) / A(I,I);
 end;
 
 eltime = cputime-t; %total elapse time
 

 OUP = 1;

%Find the maximal error of computationed solution 

 ERRMAX=0.0;
 for I=1:N
    TMP=abs(X(I)-????);    %exact solution value Xi
    if TMP > ERRMAX
       ERRMAX=TMP;
    end; 
 end; 
 
 fprintf(OUP, '\nGAUSSIAN ELIMINATION\n');
 fprintf (OUP, 'With %d row interchange(s)\n', ICHG);

 fprintf(OUP, '\nThe matrix dimension =  %d X %d \n', N,N);

 fprintf(OUP, 'MAX ERROR=  %12.8e\n', ERRMAX);
 
 if ERRMAX<0.00001,
 fprintf(OUP, '\nCpu time is %12.8e\n',eltime); 
 else
  fprintf(OUP, 'Something is wrong. \n');    
 end;
 

 end;
 end;

 end;
