close all; clear all; clc;


%% 3. Create a section of  the skin surface in normal condition (intial values) 
%3.1 Empty cells
                                       
N = zeros(40,40);

%3.2 Normal C.acne 
for k = 1   
for n1 = round(numel(N)*0.70) 
  
N(randperm(numel(N), n1)) = k;        % round = rounds to the nearest integer % numel(N)= number of elements of the matrix
                                      % N(randperm(numel(N), n2)) takes 240 grid cells (n2) randomly from the matrix 
end 
end

l =2;
[x,j]=find(N==0);
T=[x,j];
n =round(length(T)*2/3);
q=randsample(length(T),n);
for i = q
Subst=T(i,:);              %saves the empty positions in the array 
end
N(sub2ind(size(N),Subst(:,1),Subst(:,2)))=l;


%3.5 Normal s.aureus
 y=3;
[x,j]=find(N==0);
T=[x,j];
z =round(length(T)*1/100);
q=randsample(length(T),z);
for i = q
Subst=T(i,:);              %saves the empty positions in the array 
end
N(sub2ind(size(N),Subst(:,1),Subst(:,2)))=y;
% for m= 3  
% for n3 = 0                     % since we don't have any latent T-cell at the beginning
% N(randperm(numel(N), n3)) = m;
% end
% end
%% 4. This section creates a frame around the skin 
[rader, kolumner]=size(N);   % this is our matrix i.e. the blood vessel tisssue. 
r=6*ones(rader, 1);          % creates a row of 6s
k=6*ones(1,kolumner+2);      % creates a column with 2 extra grid cells 

a=[r,N,r];                   % adds 2 rows at the top and the bottom of the matrix N
a=[k;a;k];                   % adds 2 columns on the leftmost and the rightmost of the matrix N



%% %% 7. Interaction rules between agents

% Assigned numbers for the agents in the matrix
% 0 = empty gridcells
% 1 = c.acne IA1 phylotype
% 2 = s.epidermidis
% 3 = s.aureus
q = 1;     % sets the limit for the rand function 

%% Selecting parameters 
C= 0.0224 ; % normal c.acne growth rate (day^-1)
alpha = 0.0224 ;%normal c.acne death rate (day^-1)
S = 0.0224 ;%normal s.epidermidis growth rate
beta = 0.0224;  %normal s.epidermidis death rate
A= 0.0224;
gamma = 0.0224;
counter = 1;
for n = 1:29

%6.3 The growthrate of c.acne (0->T)
[x1,j1]=find(a==1);     
[x2,j2]=find(a==0);      
T1=[x1,j1]; 
T2 = [x2,j2];
n4 =round(length(T1)*C);     
q4=randsample(length(T2),n4);   
%%subst7=[];                           
for i = q4
Subst7=T2(i,:);             
end
a(sub2ind(size(a),Subst7(:,1),Subst7(:,2)))=1;     
 
%6.5 Converting C.acne to empty grid cells this is due to death (TA-> 0)
[x3,j3]=find(a==1);            
TA=[x3,j3];                   
r=round(length(T1)*alpha);       
q5=randsample(length(T1),r);  
% subst4=[];                     
for i=q5
Subst4=T1(i,:);  
end
a(sub2ind(size(a),Subst4(:,1),Subst4(:,2))) = 0;  


%6.3 The growthrate of s.ep (0->T)
[x4,j4]=find(a==2);     
[x5,j5]=find(a==0);     
T3=[x4,j4];  
T4 = [x5,j5];           
n6 =round(length(T3)*S);     
q6=randsample(length(T4),n6);  
                          
for i = q6
Subst8=T4(i,:);             
end
a(sub2ind(size(a),Subst8(:,1),Subst8(:,2)))=2;     
 

%6.5 Converting s.ep to empty grid cells this is due to lysis (TA-> 0)
[x6,j6]=find(a==2);             
TB=[x6,j6];                     
d=round(length(T3)*beta);      
q3=randsample(length(T3),d);   
                     
for i=q3
Subst5= T3(i,:);       
end
a(sub2ind(size(a),Subst5(:,1),Subst5(:,2))) = 0;  

%6.4 The growthrate of s.aur (0->T)
[x6,j6]=find(a==3);     
[x7,j7]=find(a==0);      
T5=[x6,j6];              
T6=[x7,j7];              
n7 =round(length(T5)*A);     
q7=randsample(length(T6),n7);   
                            
for i = q7
Subst9=T6(i,:);               
end
a(sub2ind(size(a),Subst9(:,1),Subst9(:,2)))=3;    
 

%6.5 Converting s.ep to empty grid cells this is due to lysis (TA-> 0)
[x6,j6]=find(a==2);            
TB=[x6,j6];                    
e=round(length(T5)*gamma);      
q8=randsample(length(T5),e);  
                    
for i=q8
Subst2= T5(i,:);       
end
a(sub2ind(size(a),Subst2(:,1),Subst2(:,2))) = 0;  


%% defining acid procution and death rate  --> for balanced condition
 kp = 0.01;
 kd = 0.007;
 mp = 0.01;
 md = 0.002;
 ld = 0.002;
lp = 0.1;
od = 0.007;
op = 0.1;

%% defining acid procution and death rate  --> for un-balanced condition.  
%Choose these parameters to see the simulation for un-balanced condition and make sure to comment out the parameters above!
% kp = 0.01;
% kd = 0.007;
% mp = 0.01;
% md = 0.003;
% ld = 0.004;
% lp = 0.0555;
% od = 0.007;
% op = 0.03;

%% Equations describing interaction between the three bacteria 
[c1,d1] = find(a==1);
[s1,r1] = find(a==2);
[f1,g1] = find(a==3);
[dead,dead2] = find(a==0);
n_c(counter) = numel(c1);
n_ep(counter)= numel(s1);
n_au(counter) = numel(f1);
n_zero(counter)= numel(dead);
prop(counter) = kp*n_c(counter);
succ(counter) = mp*n_ep(counter);
corp(counter) = lp *n_c(counter);
pep(counter) = op *n_ep(counter);
alpha = kd*succ(counter);
beta = md*prop(counter);
gamma = od*pep(counter);
A = ld*corp(counter);
 
%% 5. plotting the normal skin condition
figure(2)
subplot (3,2,1)
plot (((n_c)/16))
title ('c.acne')
xlabel('cycles')            
ylabel('quantity (%)')
subplot(3,2,2)
plot (prop/11.2);
title ('c.acne')
xlabel('cycle')            
ylabel('Propionic acid level')
subplot (3,2,3)
plot (((n_ep)/16));
title ('s.epidermidis')
xlabel('cycles')            
ylabel('quantity(%)')
subplot(3,2,4)
plot (succ/3.2);
title ('s.epidermidis')
xlabel('cycles')            
ylabel('Succinic acid level')
subplot (3,2,5)
plot (((n_au)/16));
title ('s.aureus')
xlabel('cycles')            
ylabel('quantity(%)')
subplot (3,2,6)
plot (pep/32,'-k');
title ('s.aureus')
hold on
plot (corp/112,'-b');
xlabel('cycles')            
ylabel('Chemical level')
legend('glutamyl endopeptidase','coproporphyrin III','location','north')
ylim([0.8, 1.5])
sgtitle('Normal skin') 
fName = ['normal_',num2str(counter),'.jpg'];
saveas(gca,fName);
figure(1)
hold on
imagesc(a)               % display an image of the matrix a with scaled colors using a colormap
colormap copper          %copper is the chosen colormap 
colorbar  % shows the color scale 
colorbar('Ticks',[0,1,2,3],'TickLabels',{'other','c.acne','s.epidermidis','s.aureus'})
title ('Balanced skin microbe interaction')
%choose the title below when simulating the un-balanced condition and make sure to comment out the title above!
%title ('Dysbiosis skin microbe interaction')
fName = ['normalanimation_',num2str(counter),'.jpg'];
saveas(gca,fName);
counter = counter + 1;  % counts the number of iteratios


end 
disp(counter)
