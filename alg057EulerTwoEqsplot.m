% EULER Method FOR SYSTEMS OF DIFFERENTIAL EQUATIONS ALGORITHM 5.7
%
% TO APPROXIMATE THE SOLUTION OF THE MTH-ORDER SYSTEM OF FIRST-
% ORDER INITIAL-VALUE PROBLEMS
%            UJ' = FJ( T, U1, U2, ..., UM ), J = 1, 2, ..., M
%            A <= T <= B, UJ(A) = ALPHAJ, J = 1, 2, ..., M
% AT (N+1) EQUALLY SPACED NUMBERS IN THE INTERVAL (A,B).
%
% INPUT:   ENDPOINTS A,B; NUMBER OF EQUATIONS M; INITIAL
%          CONDITIONS ALPHA1, ..., ALPHAM; INTEGER N.
%
% OUTPUT:  APPROXIMATION WJ TO UJ(T) AT THE (N+1) VALUES OF T.
 syms('OK', 'M', 'I', 'A', 'B', 'ALPHA', 'N', 'FLAG');
 syms('NAME', 'OUP', 'H', 'T', 'J', 'W', 'L', 'K','s1','s2','u');
 syms('K1','Z','ssol1','ssol2');
 TRUE = 1;
 FALSE = 0;
 fprintf(1,'This is the Euler Method for Systems of 2 equations\n');
 fprintf(1,'\n');
 OK = FALSE;
 while OK == FALSE
 fprintf(1,'The number of equations must be 2.\n');
 M = 2;
 OK = TRUE;
 end;
 
 I=1; 
 fprintf(1,'Input the function F1_(%d) in terms of t and y1, y%d\n', I,M);
 fprintf(1,'For example: y1-y2\n');
 s1 = input(' ','s');
 F1 = inline(s1,'t','y1','y2');
 I=2;
 fprintf(1,'Input the function F2_(%d) in terms of t and y1, y%d\n', I,M);
 fprintf(1,'For example: -2y1+2y2-t+1 \n');
 s2 = input(' ','s');
 F2 = inline(s2,'t','y1','y2');
 
 OKS=TRUE;
 fprintf(1,'If exact solution is not available, just ENTER YES.\n');
 reply = input('Is the exact solution is available? (y/n): ','s');
 if strcmp(reply,'n') 
  OKS=FALSE; 
 else
    I=1;
    fprintf(1,'Input the exact solution y%d in terms of t \n',I);
    fprintf(1,'For example:  (t+1)^2-0.5*exp(t)  \n');
    ssol1 = input(' ','s');
    SOL1=inline(ssol1,'t');
    I=2;
    fprintf(1,'Input the exact solution y%d in terms of t \n',I);
    fprintf(1,'For example:  (t+1)^2-0.5*exp(t)  \n');
    ssol2 = input(' ','s');
    SOL2=inline(ssol2,'t');    
  
 end; 
 OK = FALSE;
 while OK == FALSE
 fprintf(1,'Input left and right endpoints on separate lines.\n');
 A = input(' ');
 B = input(' ');
 if A >= B
 fprintf(1,'Left endpoint must be less than right endpoint\n');
 else
 OK = TRUE;
 end;
 end;
 ALPHA = zeros(1,M);
 for I = 1:M
 fprintf(1,'Input the initial condition alpha(%d)\n', I);
 ALPHA(I) = input(' ');
 end;
 OK = FALSE;
 while OK == FALSE
 fprintf(1,'Input a positive integer for the number of subintervals\n');
 N = input(' ');
 if N <= 0
 fprintf(1,'Number must be a positive integer\n');
 else
 OK = TRUE;
 end;
 end;
 if OK == TRUE
 fprintf(1,'Choice of output method:\n');
 fprintf(1,'1. Output to screen\n');
 fprintf(1,'2. Output to text file\n');
 fprintf(1,'Please enter 1 or 2\n');
 FLAG = input(' ');
 if FLAG == 2
 fprintf(1,'Input the file name in the form - drive:\\name.ext\n');
 fprintf(1,'For example   A:\\OUTPUT.DTA\n');
 NAME = input(' ','s');
 OUP = fopen(NAME,'wt');
 else
 OUP = 1;
 end;
 fprintf(OUP,'EULER METHOD FOR SYSTEMS OF DIFFERENTIAL EQUATIONS\n\n');

% STEP 1
 W = zeros(1,M);
 V = zeros(1,M+1);
 WAP=zeros(N+1,M);
 WSOL=zeros(N+1,M);
 VSOL=zeros(1,1);
 
 K1 = zeros(1,M);
 H = (B-A)/N;
 T = A;
% STEP 2
 for J = 1:M
 W(J) = ALPHA(J);
 WAP(1,J)=W(J);
 WSOL(1,J)=W(J); 
 end;
% STEP 3
if OKS==TRUE
  fprintf(OUP, '    T');
  for I = 1:M
   fprintf(OUP, '       W%d         Y%d-w%d',I,I,I);
  end;    
  fprintf(OUP, '\n%5.3f', T);
  for I = 1:M
   fprintf(OUP, ' %11.8f %11.8f', W(I), W(I)-W(I));
  end;
  fprintf(OUP, '\n');
else    
  fprintf(OUP, '    T');
  for I = 1:M
   fprintf(OUP, '          W%d', I);
  end;    
  fprintf(OUP, '\n%5.3f', T);
  for I = 1:M
   fprintf(OUP, ' %11.8f', W(I));
  end;
  fprintf(OUP, '\n');
end;
 
  
 fprintf(OUP, '\n');
% STEP 4
 for L = 1:N
     
% STEP 5
 V(1) = T;
 for J = 2:M+1
 V(J) = W(J-1);
 end;
 
 K1(1) = H*F1(V(1),V(2),V(3));
 K1(2) = H*F2(V(1),V(2),V(3));

% STEP 9
 for J = 1:M
 W(J) = W(J)+ K1(J);
 WAP(L+1,J)=W(J);
 end;
% STEP 10
 T = A+L*H;
  WSOL(L+1,1)=SOL1(T);
  WSOL(L+1,2)=SOL2(T);

% STEP 11
 if OKS==TRUE
   fprintf(OUP, '%5.3f', T);
   for I = 1:M
    fprintf(OUP, ' %11.8f %11.8f', W(I),WSOL(L+1,I)-W(I));
   end;
   fprintf(OUP, '\n');    
 else    
   fprintf(OUP, '%5.3f', T);
   for I = 1:M
    fprintf(OUP, ' %11.8f', W(I));
   end;
   fprintf(OUP, '\n');
 end;

 end;
% STEP 12
 if OUP ~= 1 
 fclose(OUP);
 fprintf(1,'Output file %s created successfully \n',NAME);
 end;
 end;
 
 
  tt=linspace(A,B,N+1); 
   
  
  figure;  
  if  OKS==TRUE
    h1=plot(tt,WAP(:,1),'b*-'); hold on; 
    h2=plot(tt,WSOL(:,1),'b^--');
    h3=plot(tt,WAP(:,2),'r*-');
    h4=plot(tt,WSOL(:,2),'r^--');
    legend([h1,h2,h3,h4],'Euler Method for y1','Exact solution of y1', 'Euler Method for y2','Exact solution of y2','Location','NorthWest');

  else
    plot(tt,WAP(:,1),'*-'); hold on; 
    legend('Euler Method','Location','NorthWest');
    plot(tt,WAP(:,2),'*-');
  end; 
 
  
  xlabel('t'); ylabel('y'); 
  box on; grid on;   
