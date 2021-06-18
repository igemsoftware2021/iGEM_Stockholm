clc
close all

%% 1. Setting parameters

s=1;              % T-cell from precursor supply rate ((mm^3/day)^-1 )
R= 0.01;          % normal T-cell growth rate (day^-1)
Tmax=1500;        % maximum T-cell population ((mm^3)^-1)
mu=0.02;          % normal/latently infected T-cell death rate (day^-1)
beta=0.05;        % actively infected T-cell death rate (day^-1)
alfa=0.01;        % free virus death rate (day^-1)
k1=0.7;           % T-cell infection rate by free virus (mm^3/day) 2.4*10^-5
k2=0.02;          % latent-to-active T-cell conversion rate (day^-1)
N1=10;            % virus produced by an active T-cell (#)
%% 2. different treatment case (choose one m1 value!!!, m1=0 is chosen as a default)
% Case 1: patient dies due to no treatment
m1=0.0;            % m1: latent-to-normal T-cell conversion rate (day^-1)

% No recovery 
%case 2: 
%m1=0.01;

%case 3
%m1=0.02;

%case4:
%m1=0.03;

%case5:
%m1=0.04;

%case6:
%m1=0.05;

% Recovery 
% Case 7: threshold between death and recovery (0.05_0.07)
%m1=0.06;    % latent-to-normal T-cell conversion rate (day^-1)

%case 8
%m1=0.07;

%case 9
%m1=0.08;

%case10
%m1=0.09;

%Case 11       
%m1=0.1; 

%case 12
%m1=0.12;

%Case 13
%m1=0.14;

%case 14
%m1=0.16

%case 15
%m1=0.18

%case16
%m1=0.2

%% 3. Create a transection of a blood vessel (intial values)

 %3.1 Empty cells
for i = 0                      
    N = zeros(40,40);
end

%3.2 Normal T-cells
for k = 1   
for n2 = round(numel(N)*0.15)         % 15% of the matrix (240 grid cells )
N(randperm(numel(N), n2)) = k;        % round = rounds to the nearest integer % numel(N)= number of elements of the matrix
                                      % N(randperm(numel(N), n2)) takes 240 grid cells (n2) randomly from the matrix 
end 
end

%3.3 Latent T-cells
for l = 2  
for n3 = 0                      % since we don't have any latent T-cell at the beginning 
N(randperm(numel(N), n3)) = l;  
end
end

%3.4 Active T-cells
for m=3    
for n4 = 0                      % since we don't have any latent T-cell at the beginning
N(randperm(numel(N), n4)) = m;
end
end

%3.5 Virus
for j33=4    
    for n5 = round(numel(N)*0.05)  % 5% of the matrix (80 grid cells ) 
       N(randperm(numel(N), n5)) = j33;
    end
end

%% 4. This section creates a frame around the blood vessel.

[rader, kolumner]=size(N);   % this is our matrix i.e. the blood vessel tisssue. 
r=6*ones(rader, 1);          % creates a row of 6s
k=6*ones(1,kolumner+2);      % creates a column with 2 extra grid cells 

a=[r,N,r];                   % adds 2 rows at the top and the bottom of the matrix N
a=[k;a;k];                   % adds 2 columns on the leftmost and the rightmost of the matrix N

%% 5. Creating empty vectors for plotting the sum of agents through iterations 
V1=[];
V2=[];
V3=[];
V4=[];
%% 6. Interaction rules between agents

% Assigned numbers for the agents in the matrix
% 0 = empty gridcells
% 1 = normal t-cell
% 2 = latent t-cell
% 3 = active t-cell
% 4 = virus

 
q = 1;     % sets the limit for the rand function 

counter = 1;
for n = 1:200
    for x = 2:39       % in order to keep the interaction rules within the frame. 
        for y = 2:39   % see the comment above 
            
l3 = rand(q);        % the rand function selects a random number between 0 to 1. 

% Positions in the matrix 
pos1 = a(x-1,y-1);
pos2 = a(x-1,y);
pos3 = a(x-1,y+1);
pos4 = a(x,y-1);
pos5 = a(x,y+1);
pos6 = a(x+1,y-1);
pos7 = a(x+1,y);
pos8 = a(x+1,y+1);
pos9 =  a(x,y);

       %6.1 Interaction between the virus and normal T-cells
       
if pos9 == 1 && pos1 == 4 && l3 >= k1   % recall k1, T-cell infection rate by free virus
a(x,y) = 2;
a(x-1,y-1) = 0;
end

if pos9 == 1 && pos2 == 4 && l3 >= k1
a(x,y) = 2;
a(x-1,y) = 0;

end

if pos9 == 1 && pos3 == 4 && l3 >= k1
a(x,y) = 2;
a(x-1,y+1)=0;

end

if pos9 == 1 && pos4 == 4 && l3 >= k1
a(x,y) = 2;
a(x,y-1)=0;

end

if pos9 == 1 && pos5 == 4 && l3 >= k1
a(x,y) = 2;
a(x,y+1) = 0;

end
 
if pos9 == 1 && pos6 == 4 && l3 >= k1
a(x,y) = 2;
a(x+1,y-1) = 0;

end

if pos9 == 1 && pos7 == 4 && l3 >= k1
a(x,y) = 2;
a(x+1,y) = 0;
end

if pos9 == 1 && pos8 == 4 && l3 >= k1
a(x,y) = 2;
a(x+1,y+1) = 0;

end
end
    end 

      % 6.2 The supply of normal T-cells by the lymphatic system  (0->T) 
       
[x1,j1]=find(a==0);             % find the positions of the empty grid cells in the matrix  
T=[x1,j1];                      % save all the positions in a matrix 
q1=randsample(length(T),s);     % randomly extract s (1) positions from T. 
subst1=[];                      % creates an empty array to keep the substituted agent i.e. normal T-cells
for i = q1                      
Subst1=[subst1;T(i,:)];         %saves the empty positions in the array 
end
a(sub2ind(size(a),Subst1(:,1),Subst1(:,2)))=1;   %substitute the empty grid cells with normal T-cells (0->1)  

       %6.3 The growthrate of normal T-cells (0->T)
[x2,j2]=find(a==1);     % find the positions of the normal T-cells in the matrix 
[x9,j9]=find(a==0);     % find the positions of the empty grid cells in the matrix 
T7=[x2,j2];             % save all the positions of the normal T-cells in a matrix 
T9=[x9,j9];             % save all the positions of the empty grid cells in a matrix
n7 =round(length(T7)*R);     % rounds up the product of the number of normal T-cells and the growthrate
q7=randsample(length(T9(:,1)),n7);   % randomly extract n7 positions from T9. 
subst7=[];                            % creates an empty array to keep the substituted agent i.e. empty grid cells
for i = q7
Subst7=[subst7;T9(i,:)];              %saves the empty positions in the array 
end
a(sub2ind(size(a),Subst7(:,1),Subst7(:,2)))=1;    %substitute the empty grid cells with normal T-cells (0->1)  

        %6.4 Converting latent T-cells to active T-cells (TL->TA)
[x3,j3]=find(a==2);                %find the positions of the latent T-cells in the matrix a 
TL=[x3,j3];                        %save all the positions in a matrix 
z=round(length(TL)*k2);            % rounds up the product of the number of latent T-cells and the conversion rate (k2)
q3=randsample (length(TL(:,1)),z);  % randomly extract z positions from TL. 
subst3=[];                          % creates an empty array to keep the substituted agent i.e. latent T-cells
for i = q3
Subst3=[subst3;TL(i,:)];             %saves the latent T-cells positions in the array 
end
a(sub2ind(size(a),Subst3(:,1),Subst3(:,2))) = 3;  %substitute the latent T-cells with active T-cells (2->3)  

          %6.5 Converting active T-cells to empty grid cells this is due to lysis (TA-> 0)
[x4,j4]=find(a==3);            %find the positions of the active T-cells in the matrix a 
TA=[x4,j4];                    %save all the positions in a matrix 
r=round(length(TA)*beta);      %rounds up the product of the number of active T-cells and its death rate (beta) 
q4=randsample(length(TA),r);   % randomly extract r positions from TA.
subst4=[];                     % creates an empty array to keep the substituted agent i.e. active T-cells
for i=q4
Subst4=[subst4;TA(i,:)];       %saves the active T-cells positions in the array 
end
a(sub2ind(size(a),Subst4(:,1),Subst4(:,2))) = 0;  %substitute the active T-cells with empty grid cells (3->0)

         %6.6 Virus production due to lysis of TA (0->4) 
[x7,j7]=find(a==0);                 %find the positions of the empty grid cells in the matrix a 
T19=[x7,j7];                        %save all the positions in a matrix 
r19=round(r*N1);                     %rounds up the rounded product of the lysed active T-cells and the virus production rate 
q19=randsample (length(T19),r19);    % randomly extract r19 positions from TA.
subst19=[];                         % creates an empty array to keep the empty grid cells
for i=q19
Subst19=[subst19;T19(i,:)];         %saves the empty grid cells positions in the array 
end
a(sub2ind(size(a),Subst19(:,1),Subst19(:,2))) = 4;   %substitute the empty grid cells with virus (0->4)

      %6.7 Free virus death rate (4->0)
[x5,j5]=find(a==4);           %find the positions of the virus in the matrix a 
V=[x5,j5];                    %save all the positions in a matrix 
r2=round(length(V)*alfa);     %rounds up the product of the number of free virus and its death rate (alfa) 
q5=randsample (length(V),r2);   % randomly extract r2 positions from V.
subst5=[];                      % creates an empty array to keep the free virus positions
for i=q5
Subst5=[subst5;V(i,:)];         %saves the free virus positions in the array 
end
a(sub2ind(size(a),Subst5(:,1),Subst5(:,2)))= 0;      %substitute the virus with empty grid cells (4->0)

       %6.8 NRTI treatment (2->1)
[x6,j6]=find(a==2);              %find the positions of the latent T-cells in the matrix a 
TL1=[x6,j6];                     %save all the positions in a matrix 
r3=round(length(TL1)*m1);        %rounds up the product of the number of latent T-cells and the medication rate (m1) 
q6=randsample(length(TL1),r3);   %randomly extract r3 positions from TL1.
subst6=[];                       %creates an empty array to keep the latent T-cells positions
for i=q6
Subst6=[subst6;TL1(i,:)];        %saves the latent T-cells positions in the array 
end
a(sub2ind(size(a),Subst6(:,1),Subst6(:,2)))= 1;     %substitute the latent T-cells with normal T-cells (2->1)

%% 7. CREATE PLOTS
figure(1)
hold on
imagesc(a)               % display an image of the matrix a with scaled colors using a colormap
colormap jet             %jet is the chosen colormap
colorbar                 % shows the color scale 0= dark blue, 1 = blue, 2 = light blue, 3 = light green and 4 = yellow
title ('Cross-transection of blood vessel')

counter = counter + 1;  % counts the number of iteratios

   %% 8. the patient's destiny 
   
virus=sum(a==4,'all');
if virus >= 1600* 0.5
    disp 'DEAD';
    break  
elseif virus <= 1600* 0.01     % undetectable level is reached 
    disp 'Recovered';
    break
end

%% 9. plotting the number of agents on the grid 
     
v1= sum(a==1,'all');     % summing up the number of normal T-cells after each iteration
V1=[V1 v1];              % saving the number of normal T-cells after each iteration in V1
v2= sum(a==2,'all');     % summing up the number of latent T-cells after each iteration
V2=[V2 v2];              % saving the number of latent T-cells after each iteration in V2
v3= sum(a==3,'all');     % summing up the number of active T-cells after each iteration
V3=[V3 v3];              % saving the number of active T-cells after each iteration in V3
v4= sum(a==4,'all');     % summing up the number of free virus after each iteration
V4=[V4 v4];              % saving the number of free virus after each iteration in V4
  
       % creating a plot for the number of each agent through time (iterations)
       % one iteration is equivalent to one month (100 iterations = 8.3 years) 
       
figure (2)
subplot (2,2,1)
plot (V1);
title ('Normal T-cells')
xlabel('Time (months)')            
ylabel('Number of cells')

subplot (2,2,2)
plot (V2);
title ('Latent T-cells')
xlabel('Time (months)')
ylabel('Number of cells')

subplot (2,2,3)
plot (V3);
title ('Active T-cells')
xlabel('Time (months)')
ylabel('Number of cells')

subplot (2,2,4)
plot (V4);
title ('Virus')
xlabel('Time (months)')
ylabel('Number of cells')
end

disp(counter)   % displays the number of iterations
disp (counter/12) % displays the number of years 

