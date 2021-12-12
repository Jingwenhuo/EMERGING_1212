clear all
clc;    
tic; 

%MRIO=load(['/Users/jingwen/OneDrive/EMERGING_CO2/global_mrio_2015_new.mat'],'-mat');
CO2=cell2mat(struct2cell(load(['/Users/jingwen/OneDrive/MRIO_Method/Validation/CO2/OECD_CO2.mat'],'-mat')));
co2=sum(CO2,2);
MRIO=xlsread(['/Users/jingwen/OneDrive/MRIO_Method/Validation/OECD_2015.xlsx']);
z=MRIO(1:69*36,1:69*36);  
x=MRIO(1:69*36,end);  
va=MRIO(end-1,1:69*36)';
result_va=zeros(69,1);
result_co2=zeros(69,1);
for i=1:69
    result_va(i,1)=sum(va((i-1)*36+1:i*36),1);
    result_co2(i,1)=sum(co2((i-1)*36+1:i*36,1));
end
f_tmp=MRIO(1:69*36,69*36+1:69*36+65*6); %将tmp Mexio和China
f=zeros(69*36,69*6);
for i=1:65
    if i==23
        ratio1=x((66-1)*36+1:66*36,1)./(x((66-1)*36+1:66*36,1)+x((67-1)*36+1:67*36,1));
        ratio2=x((67-1)*36+1:67*36,1)./(x((66-1)*36+1:66*36,1)+x((67-1)*36+1:67*36,1));
        ratio1(isnan(ratio1))=0;
        ratio1(isinf(ratio1))=0;
        ratio2(isnan(ratio2))=0;
        ratio2(isinf(ratio2))=0;
        for j=1:65
          f((j-1)*36+1:j*36,(66-1)*6+1:66*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio1;
          f((j-1)*36+1:j*36,(67-1)*6+1:67*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio2;
        end
        f(:,(i-1)*6+1:i*6)=0;
    elseif i==42
        ratio1=x((68-1)*36+1:68*36,1)./(x((68-1)*36+1:68*36,1)+x((69-1)*36+1:69*36,1));
        ratio2=x((69-1)*36+1:69*36,1)./(x((68-1)*36+1:68*36,1)+x((69-1)*36+1:69*36,1));
        ratio1(isnan(ratio1))=0;
        ratio1(isinf(ratio1))=0;
        ratio2(isnan(ratio2))=0;
        ratio2(isinf(ratio2))=0;
        for j=1:65
          f((j-1)*36+1:j*36,(68-1)*6+1:68*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio1;
          f((j-1)*36+1:j*36,(69-1)*6+1:69*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio2;
        end
        f(:,(i-1)*6+1:i*6)=0;
    else
        f(:,(i-1)*6+1:i*6)=f_tmp(:,(i-1)*6+1:i*6);
    end  
end

%co2=[co2(1:22*36,1);zeros(36,1);co2(22*36+1:40*36,1);zeros(36,1);co2(40*36+1:67*36,1)];
% 
X=x;
A=z./X';
A(isnan(A))=0;
A(isinf(A))=0;

I=eye(size(A));
L=(I-A)^-1;
X=L*sum(f,2);
%%%%% Economic footprint
S=(va./X)';
S(isnan(S))=0;
S(isinf(S))=0;

Multiplier=(S)*L;
Multiplier1=diag(S)*L;

for i=1:69
    %Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
    %Y=sum(f(:,i:141:end),2);
    Y=sum(f(:,(i-1)*6+1:(i-1)*6+6),2);
    VAAA=Multiplier*diag(Y);

    VAAA1=sum(VAAA,1);
    
    for j=1:69
    VAF2(j,1:36)=VAAA1(1,(j-1)*36+1:(j-1)*36+36);
    end
    
    VAF3=sum(VAF2,1);
    VAF4(:,i)=VAF3';
end


Class=xlsread('Sector+list_17.xlsx','Bridge OECD');
Class(isnan(Class))=0;
Sector_va=sum(VAF4,2);
Sector_va_17=sum(VAF4'*Class);

%%%% flow
for i=1:69
     %Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
     %Y=sum(f(:,i:141:end),2);
     Y=sum(f(:,(i-1)*6+1:(i-1)*6+6),2);
     VA_GTAP(:,i)=Multiplier1*Y;
     Footprint_va(i,1)=sum(VA_GTAP(:,i),1);
end

%%%%% Emission footprint
S=(co2./X)';
S(isnan(S))=0;
S(isinf(S))=0;

Multiplier=(S)*L;
Multiplier1=diag(S)*L;

for i=1:69
    %Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
    %Y=sum(f(:,i:141:end),2);
    Y=sum(f(:,(i-1)*6+1:(i-1)*6+6),2);
    VAAA=Multiplier*diag(Y);

    VAAA1=sum(VAAA,1);
    
    for j=1:69
    VAF2(j,1:36)=VAAA1(1,(j-1)*36+1:(j-1)*36+36);
    end
    
    VAF3=sum(VAF2,1);
    VAF4(:,i)=VAF3';
end


Class=xlsread('Sector+list_17.xlsx','Bridge OECD');
Class(isnan(Class))=0;
Sector_co2=sum(VAF4,2);
Sector_co2_17=sum(VAF4'*Class);

%%%% flow
for i=1:69
     %Y=sum(f(:,(i-1)*3+1:(i-1)*3+3),2);
     %Y=sum(f(:,i:141:end),2);
     Y=sum(f(:,(i-1)*6+1:(i-1)*6+6),2);
     VA_GTAP(:,i)=Multiplier1*Y;
     Footprint_co2(i,1)=sum(VA_GTAP(:,i),1);
end

toc