clear all
clc;    
tic; 

CO2=cell2mat(struct2cell(load(['/Users/jingwen/OneDrive/MRIO_Method/Validation/CO2/Eora_CO2.mat'],'-mat')));
co2=sum(CO2,2);
Z=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_T.txt');
F=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_FD.txt');
VA=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_VA.txt');

VA1=sum(VA,1);
x=sum(Z,1)+VA1;
result_va=zeros(189,1);
result_co2=zeros(189,1);
for i=1:189
    result_va(i,1)=sum(VA1(1,(i-1)*26+1:i*26));
    result_co2(i,1)=sum(co2((i-1)*26+1:i*26,1));
end

A=Z./x;

A(isnan(A))=0;
A(isinf(A))=0;

I=eye(size(A));
L=(I-A)^-1;
X=(L*sum(F,2))';
%%%%% Economic footprint
S=(VA1./X);
S(isnan(S))=0;
S(isinf(S))=0;

Multiplier=(S)*L;
Multiplier1=diag(S)*L;

for i=1:190
    Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
    VAAA=Multiplier*diag(Y);

    VAAA1=sum(VAAA,1);
    for j=1:189
      VAF2(j,1:26)=VAAA(1,(j-1)*26+1:(j-1)*26+26);
    end
    
    VAF3=sum(VAF2,1);
    VAF4(:,i)=VAF3';
end


Class=xlsread('Sector+list_17.xlsx','Bridge Eora');
Class(isnan(Class))=0;
Sector_va=sum(VAF4,2);
Sector_va_17=sum(VAF4'*Class);


%%%% flow
for i=1:189
     Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
     A=Multiplier*Y;
     Footprint_va(i,1)=A;
end

%%%%% Emission footprint
co2=[co2;0];
S=(co2'./X);
S(isnan(S))=0;
S(isinf(S))=0;

Multiplier=(S)*L;
Multiplier1=diag(S)*L;

T=0;
for i=1:190
    Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
    VAAA=Multiplier*diag(Y);

    VAAA1=sum(VAAA,1);
    T=T+sum(VAAA1);
    for j=1:189
      VAF2(j,1:26)=VAAA(1,(j-1)*26+1:(j-1)*26+26);
    end
    
    VAF3=sum(VAF2,1);
    VAF4(:,i)=VAF3';
end


Class=xlsread('Sector+list_17.xlsx','Bridge Eora');
Class(isnan(Class))=0;
Sector_co2=sum(VAF4,2);
Sector_co2_17=sum(VAF4'*Class);


%%%% flow
for i=1:189
     Y=sum(F(:,(i-1)*6+1:(i-1)*6+6),2);
     A=Multiplier*Y;
     Footprint_co2(i,1)=A;
end

toc