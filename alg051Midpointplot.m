 % MODIFIED EULER ALGORITHM 
 %
 % TO APPROXIMATE THE SOLUTION OF THE INITIAL VALUE PROBLEM:
 %            Y' = F(T,Y), A<=T<=B, Y(A) = ALPHA,
 % AT N+1 EQUALLY SPACED POINTS IN THE INTERVAL [A,B].
 %
 % INPUT:   ENDPOINTS A,B; INITIAL CONDITION ALPHA; INTEGER N.
 %
 % OUTPUT:  APPROXIMATION W TO Y AT THE (N+1) VALUES OF T.
 %syms('F','OK','A','B','ALPHA','N','FLAG','NAME','OUP','H');
 %syms('T','W','I','x','s');
 TRUE = 1;
 FALSE = 0;
 fprintf(1,'This is Midpoint Method.\n');
 fprintf(1,'Input the function F(t,y) in terms of t and y\n');
 fprintf(1,'For example: y-t^2+1\n');
 s = input(' ','s');
 F = inline(s,'t','y');
 OKS=TRUE;%
 fprintf(1,'If exact solution is not available, just ENTER YES.\n');
 reply = input('Is the exact solution is available? (y/n): ','s');
 if strcmp(reply,'n') %
  OKS=FALSE; %
 else
  fprintf(1,'Input the exact solution y(t) in terms of t \n');
  fprintf(1,'For example:  (t+1)^2-0.5*exp(t)  \n');
  s = input(' ','s');
  SOL = inline(s,'t'); 
 end; % 
 
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
 fprintf(1,'Input the initial condition\n');
 ALPHA = input(' ');
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
 fprintf(OUP, 'Midpoint Method\n\n');

% STEP 1
 H = (B-A)/N;
 T = A;
 
 AP=zeros(1,N+1);
 yy=zeros(1,N+1);
 AP(1)=ALPHA;
 
  if OKS==TRUE
   yy(1)=SOL(T);
   W = ALPHA;
   fprintf(OUP, '    t        w               y-w\n\n'); 
   fprintf(OUP, '%5.3f %15.8e %15.8e\n', T, W, W-W);
 else
   W = ALPHA;
   fprintf(OUP, '    t        w  \n\n');
   fprintf(OUP, '%5.3f %15.8e \n', T, W);
 end;
 
% STEP 2
 for I = 1:N 
% STEP 3
% Compute W(I)
 WW=F(T,W);
 W = W+H*F(T+0.5*H,W+0.5*H*WW);
 AP(I+1)=W;
 
% Compute T(I)
 T = A+I*H;
 
 
% STEP 4
 if OKS==TRUE
  yy(I+1)=SOL(T);
  fprintf(OUP, '%5.3f %15.8e %15.8e\n', T, W, abs(SOL(T)-W));
 else
  fprintf(OUP, '%5.3f %11.8e \n', T, W);
 end;
 

 end;

  xx=linspace(A,B,N+1);
  figure;
  if  OKS==TRUE
    plot(xx,AP,'*-'); hold on;
    plot(xx,yy,'r^');
    legend('Midpoint Method','Exact solution', 'Location','NorthWest');
    plot(xx,yy,'r-');
  else
    plot(xx,AP,'*-'); hold on;
    legend('Midpoint Method','Location','NorthWest');
  end;  
 
  
  xlabel('t'); ylabel('y'); 
  box on; grid on;   
 
% STEP 5
 if OUP ~= 1 
 fclose(OUP);
 fprintf(1,'Output file %s created successfully \n',NAME);
 end;
 end;
