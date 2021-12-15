%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         
% The code for testing the algorithm DDC on eight real-world datasets.
% Written by Ruijia Li (ruijia2017@163.com), UESTC, June 1, 2021.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all; clc; addpath(genpath(pwd));                       

%% test 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load zoo                            % load dataset
X = Data_Normalized1(X,0,1);        % normalize data 
k = 5; lambda = 0.3;                % set the parameters     
c = 7;                              % set the number of clusters                    

%% test 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load wine                        
% X = Data_Normalized1(X,0,1);       
% k = 15; lambda = 0.8;                       
% c = 3;                                                 

%% test 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load warpPIE                            
% X = Data_Normalized2(X);       
% k = 5; lambda = 0.55;                       
% c = 10;                                                 

%% test 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load ecoli 
% k = 10; lambda = 0.8;                       
% c = 8;       

%% test 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load crx
% X = Data_Normalized1(X,0,1);  
% k = 5; lambda = 0.7;                       
% c = 2;     

%% test 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load COIL_20
% k = 5; lambda = 0.3;                       
% c = 20;     

%% test 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load gisette 
% k = 15; lambda = 0.8;                       
% c = 2;   

%% test 8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load USPS 
% k = 10; lambda = 0.65;                       
% c = 10;   

%% run DDC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Result = DDC(X,k,lambda,c);
ACC = acc(Y, Result);
NMI = nmi(Y, Result);
disp(['ACC = ',num2str(ACC), '; ', 'NMI = ', num2str(NMI)])






