 % NEWTONS INTERPOLATORY DIVIDED-DIFFERENCE FORMULA ALGORITHM 3.2        
 % To obtain the divided-difference coefficients of the                    
 % interpolatory polynomial P on the (n+1) distinct numbers x(0),          
 % x(1), ..., x(n) for the function f:                                    
 % INPUT:   numbers x(0), x(1), ..., x(n); values f(x(0)), f(x(1)),          
 %          ..., f(x(n)) as the first column Q(0,0), Q(1,0), ...,          
 %    Q(N,0) of Q, or may be computed if function f is supplied.
 % OUTPUT:  the numbers Q(0,0), Q(1,1), ..., Q(N,N) where
 %          P(x) = Q(0,0) + Q(1,1)*(x-x(0)) + Q(2,2)*(x-x(0))*             
 %          (x-x(1)) +... + Q(N,N)*(x-x(0))*(x-x(1))*...*(x-x(N-1)).
 %   syms('OK', 'FLAG', 'N', 'I', 'X', 'Q', 'A', 'NAME', 'INP','OUP', 'J');
 %   syms('s','x');
 TRUE = 1;
 FALSE = 0;
 fprintf(1,'Newtons form of the interpolation polynomial\n');
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Choice of input method:\n');
 fprintf(1,'1. Input entry by entry from keyboard\n');
 fprintf(1,'2. Input data from a text file\n');
 fprintf(1,'3. Generate data using a function F\n');
 fprintf(1,'Choose 1, 2, or 3 please\n');
 FLAG = input(' ');
 if FLAG == 1 | FLAG == 2 | FLAG == 3 
 OK = TRUE;
 end
 end
 if FLAG == 1 
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Input n\n');
 N = input(' ');
 if N > 0 
 OK = TRUE;
 X = zeros(1,N+1);
 Q = zeros(N+1,N+1);
 for I = 0:N
 fprintf(1,'Input X(%d) and F(X(%d)) ', I, I);
 fprintf(1,'on separate lines\n');
 X(I+1) = input(' ');
 Q(I+1,1) = input(' ');
 end
 FLAGI=1;
 else 
 fprintf(1,'Number must be a positive integer\n');
 end
 end
 end
 if FLAG == 2 
 fprintf(1,'Has a text file been created with the data in two columns?\n');
 fprintf(1,'Enter Y or N\n');
 A = input(' ','s');
 if A == 'Y' | A == 'y' 
 fprintf(1,'Input the file name in the form - ');
 fprintf(1,'drive:\\name.ext\n');
 fprintf(1,'For example:   A:\\DATA.DTA\n');
 NAME = input(' ','s');
 INP = fopen(NAME,'rt');
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Input n\n'); 
 N = input(' ');
 if N > 0                   
 X = zeros(1,N+1);
 Q = zeros(N+1,N+1);
 for I = 0:N
 X(I+1) = fscanf(INP, '%f',1);
 Q(I+1,1) = fscanf(INP, '%f',1);
 end
 fclose(INP);
 OK = TRUE;
 FLAGI=2;
 else
 fprintf(1,'Number must be a positive integer\n')
 end
 end
 else
 fprintf(1,'Please create the input file in two column ');
 fprintf(1,'form with the X values and\n');
 fprintf(1,'F(X) values in the corresponding columns.\n');
 fprintf(1,'The program will end so the input file can ');
 fprintf(1,'be created.\n');
 OK = FALSE;
 end
 end
 if FLAG == 3 
 fprintf(1,'Input the function F(x) in terms of x\n');
 fprintf(1,'For example: cos(x)\n');
 s = input(' ','s');
 F = inline(s,'x');
 FLAGI=3;
 OK = FALSE;
 while OK == FALSE 
 fprintf(1,'Input n\n');
 N = input(' ');
 if N > 0 
 X = zeros(1,N+1);
 Q = zeros(N+1,N+1);
 for I = 0:N
 fprintf(1,'Input X(%d)\n', I);
 X(I+1) = input(' ');
 Q(I+1,1) = F(X(I+1));
 end
 OK = TRUE;
 else
 fprintf(1,'Number must be a positive integer\n');
 end
 end
 end
 if OK == TRUE 
 fprintf(1,'Select output destination\n');
 fprintf(1,'1. Screen\n');
 fprintf(1,'2. Text file\n');
 fprintf(1,'Enter 1 or 2\n');
 FLAG = input(' ');
 if FLAG == 2 
 fprintf(1,'Input the file name in the form - drive:\\name.ext\n');
 fprintf(1,'For example:   A:\\OUTPUT.DTA\n');
 NAME = input(' ','s');
 OUP = fopen(NAME,'wt');
 else
 OUP = 1;
 end
 fprintf(OUP, 'NEWTONS INTERPOLATION POLYNOMIAL\n\n');
% STEP 1
 for I = 1:N
 for J = 1:I
 Q(I+1,J+1) = (Q(I+1,J) - Q(I,J)) / (X(I+1) - X(I-J+1));
 end
 end
% STEP 2
 fprintf(OUP, 'Input data follows:\n');      
 for I = 0:N
 fprintf(OUP,'X(%d) = %12.8f F(X(%d)) = %12.8f\n',I,X(I+1),I,Q(I+1,1));      
 end
 fprintf(OUP, '\nThe coefficients Q(0,0), ..., Q(N,N) are:\n');      
 for I = 0:N
 fprintf(OUP, '%16.12f\n', Q(I+1,I+1));
 end
 
 if FLAGI==1
  tt=linspace(X(1),X(N+1),101);
%    ya=zeros(1,101);
%    for i=1:101;
%     ya(i)=F(tt(i));
%    end;
  yy=Q(N+1,N+1)*(tt-X(N))+Q(N,N);
  for i=2:N
     yy=yy.*(tt-X(N-i+1))+Q(N-i+1,N-i+1);
  end;
  figure;
  plot(tt,yy,'b-');
  hold on;
   plot(X,Q(:,1),'r-');
   grid on;
  legend('Interpolation')
 end;
 
 if FLAGI==2
  tt=linspace(X(1),X(N+1),101);
  yy=Q(N+1,N+1)*(tt-X(N))+Q(N,N);
  for i=2:N
     yy=yy.*(tt-X(N-i+1))+Q(N-i+1,N-i+1);
  end;
  figure;
  plot(tt,yy,'b-');
  hold on;
   plot(X,Q(:,1),'r-');
   grid on;
  legend('Interpolation')
 end;
 
 
 if FLAGI==3
  tt=linspace(X(1),X(N+1),101);
  ya=zeros(1,101);
  for i=1:101;
   ya(i)=F(tt(i));
  end;
  yy=Q(N+1,N+1)*(tt-X(N))+Q(N,N);
  for i=2:N
     yy=yy.*(tt-X(N-i+1))+Q(N-i+1,N-i+1);
  end;
  figure;
  plot(tt,yy,'b-');
  hold on;
  plot(tt,ya,'r--');
  grid on;
  legend('Interpolation','Actual function')
 end;
 
 if OUP ~= 1 
 fclose(OUP);
 fprintf(1,'Output file %s created successfully\n',NAME);
 end
 end

