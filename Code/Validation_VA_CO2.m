clear all
clc;    
tic; 

MRIO=load(['/Users/jingwen/OneDrive/EMERGING_CO2/global_mrio_2015_1102.mat'],'-mat');
CO2=cell2mat(struct2cell(load(['/Users/jingwen/OneDrive/MRIO_Method/Validation/CO2/EMERGING_CO2.mat'],'-mat')));
co2=sum(CO2,2);
% MRIO=load(['/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/EXIOBASE_3rx_2015.mat'],'-mat');
% 
% %X=MRIO.IO.x; %134
% A=MRIO.IO.A;
% %z=A.*X';
% va=sum(MRIO.IO.V);
% result_va=zeros(214,1);
% result_co2=zeros(214,1);
% for i=1:214
%     result_va(i,1)=sum(va(1,(i-1)*200+1:i*200));
%     result_co2(i,1)=sum(co2((i-1)*200+1:i*200,1));
% end
% 
% f=MRIO.IO.Y;
% %a=f(:,(21-1)*7+1:(21-1)*7+7);
% MRIOT2014=load(['/Users/jingwen/OneDrive/GTAPv10_mrio_2014/MRIO2014_V10.mat'],'-mat');
% EIO_SAM_2014=MRIOT2014.EIO_SAM;  
% X=sum(EIO_SAM_2014,2);
% z=EIO_SAM_2014(1:141*65,1:141*65);
% va=(X'-sum(z))';

% f=EIO_SAM_2014(1:141*65,141*65+1:141*65+141*3);
X=MRIO.X;
z=MRIO.z;
f=MRIO.f;
f=abs(f);
va=MRIO.va;
result_va=zeros(245,1);
result_co2=zeros(245,1);
for i=1:245
    result_va(i,1)=sum(va((i-1)*134+1:i*134,1));
    result_co2(i,1)=sum(co2((i-1)*134+1:i*134,1));
end

A=z./X';
A(isnan(A))=0;
A(isinf(A))=0;
% 
I=eye(size(A));
L=inv(I-A);
X=L*sum(f,2);
% 
%%%%% Economic footprint
S=(va./X)';
S(isnan(S))=0;
S(isinf(S))=0;

Multiplier=(S)*L;
Multiplier1=diag(S)*L;

for i=1:245
    Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
    %Y=sum(f(:,i:245:end),2);
    %Y=sum(f(:,(i-1)*7+1:(i-1)*7+7),2);
    VAAA=Multiplier*diag(Y);

    VAAA1=sum(VAAA,1);
    
    for j=1:245
    VAF2(j,1:134)=VAAA1(1,(j-1)*134+1:(j-1)*134+134);
    end
    
    VAF3=sum(VAF2,1);
    VAF4(:,i)=VAF3';
end


Class=xlsread('Sector+list_17.xlsx','Bridge EMERGING');
Class(isnan(Class))=0;
Sector_va=sum(VAF4,2);
Sector_va_17=sum(VAF4'*Class);

%%%% flow
for i=1:245
     Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
     %Y=sum(f(:,i:245:end),2);
     %Y=sum(f(:,(i-1)*7+1:(i-1)*7+7),2);
     VA_Eora(:,i)=Multiplier1*Y;
     Footprint_va(i,1)=sum(VA_Eora(:,i),1);
end

%%%%% Emission footprint
S=(co2./X)';
S(isnan(S))=0;
S(isinf(S))=0;

Multiplier=(S)*L;
Multiplier1=diag(S)*L;

for i=1:245
    Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
    %Y=sum(f(:,i:245:end),2);
    %Y=sum(f(:,(i-1)*7+1:(i-1)*7+7),2);
    VAAA=Multiplier*diag(Y);

    VAAA1=sum(VAAA,1);
    
    for j=1:245
    VAF2(j,1:134)=VAAA1(1,(j-1)*134+1:(j-1)*134+134);
    end
    
    VAF3=sum(VAF2,1);
    VAF4(:,i)=VAF3';
end


Class=xlsread('Sector+list_17.xlsx','Bridge EMERGING');
Class(isnan(Class))=0;
Sector_co2=sum(VAF4,2);
Sector_co2_17=sum(VAF4'*Class);

%%%% flow
for i=1:245
     Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
     %Y=sum(f(:,i:245:end),2);
     %Y=sum(f(:,(i-1)*7+1:(i-1)*7+7),2);
     VA_Eora(:,i)=Multiplier1*Y;
     Footprint_co2(i,1)=sum(VA_Eora(:,i),1);
end

% %% Eora
% Z=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_T.txt');
% 
% F=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_FD.txt');
% 
% VA=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_VA.txt');
% VA1=sum(VA,1);
% 
% x=sum(Z,1)+VA1;
% 
% A=Z./x;
% 
% A(isnan(A))=0;
% A(isinf(A))=0;
% 
% I=eye(size(A));
% L=inv(I-A);
% 
% %%%%% Economic footprint
% S=(VA1./x);
% S(isnan(S))=0;
% S(isinf(S))=0;
% 
% Multiplier=(S)*L;
% Multiplier(1,end)=0;
% Multiplier1=diag(S)*L;
% Multiplier1(:,end)=0;
% Multiplier1(end,:)=0;
% 
% T=0;
% for i=1:190
%     Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
%     VAAA=Multiplier*diag(Y);
% 
%     VAAA1=sum(VAAA,1);
%     for j=1:189
%     VAF2(j,1:26)=VAAA1(1,(j-1)*26+1:(j-1)*26+26);
%     end
%     
%     VAF3=sum(VAF2,1);
%     VAF4(:,i)=VAF3';
% end
% 
% 
% Class=xlsread('Sector+list_17.xlsx','Bridge Eora');
% Class(isnan(Class))=0;
% Sector_va=sum(VAF4,2);
% Sector_va_17=sum(VAF4'*Class);
% 
% 
% %%%% flow
% for i=1:189
%      Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
%      VA_Eora(:,i)=Multiplier1*Y;
%      Footprint_va(i,1)=sum(VA_Eora(:,i),1);
% end
% 
% %%%%% Emission footprint
% co2=[co2;0];
% S=(co2'./x);
% S(isnan(S))=0;
% S(isinf(S))=0;
% 
% Multiplier=(S)*L;
% Multiplier(1,end)=0;
% Multiplier1=diag(S)*L;
% Multiplier1(:,end)=0;
% Multiplier1(end,:)=0;
% 
% T=0;
% for i=1:190
%     Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
%     VAAA=Multiplier*diag(Y);
% 
%     VAAA1=sum(VAAA,1);
%     T=T+sum(VAAA1);
%     for j=1:189
%       VAF2(j,1:26)=VAAA1(1,(j-1)*26+1:(j-1)*26+26);
%     end
%     
%     VAF3=sum(VAF2,1);
%     VAF4(:,i)=VAF3';
% end
% 
% 
% Class=xlsread('Sector+list_17.xlsx','Bridge Eora');
% Class(isnan(Class))=0;
% Sector_co2=sum(VAF4,2);
% Sector_co2_17=sum(VAF4'*Class);
% 
% 
% %%%% flow
% for i=1:189
%      Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
%      VA_Eora(:,i)=Multiplier1*Y;
%      Footprint_co2(i,1)=sum(VA_Eora(:,i),1);
% end

toc