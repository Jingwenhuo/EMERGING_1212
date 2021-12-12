clear all
clc;    
tic;

Class_EMERGING=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge EMERGING');
Class_EMERGING(isnan(Class_EMERGING))=0;
Class_EXIOBASE=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge EXIOBASE');
Class_EXIOBASE(isnan(Class_EXIOBASE))=0;
Class_GTAP=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge GTAP');
Class_GTAP(isnan(Class_GTAP))=0;
Class_Eora=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge Eora');
Class_Eora(isnan(Class_Eora))=0;
Class_OECD=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge OECD');
Class_OECD(isnan(Class_OECD))=0;

Region=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Code/Validation_result.xlsx','Aggregate Region');
Region_EMERGING=Region(:,1);
Region_Eora=Region(:,9);
Region_EXIOBASE=Region(:,13);
Region_OECD=Region(:,17);
Region_GTAP=Region(:,5);

EMERGING=load(['/Users/jingwen/OneDrive/EMERGING_CO2/global_mrio_2015_1102.mat'],'-mat');
x_EMERGING=EMERGING.X;
f_EMERGING=EMERGING.f;
z_EMERGING=EMERGING.z;
va_EMERGING=EMERGING.va;
f_EMERGING=abs(f_EMERGING);

export=zeros(134,1);
x=zeros(134,1);

%整合 VA Z F X
%合并部门
for i=1:245
    for j=1:245
       z_EMERGING_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17)=Class_EMERGING'*z_EMERGING((i-1)*134+1:i*134,(j-1)*134+1:j*134)*Class_EMERGING;
       f_EMERGING_tmp((j-1)*17+1:j*17,i)=(sum(f_EMERGING((j-1)*134+1:j*134,(i-1)*3+1:i*3),2)'*Class_EMERGING)';
    end
    va_EMERGING_tmp(1,(i-1)*17+1:i*17)=va_EMERGING((i-1)*134+1:i*134,1)'*Class_EMERGING;
    x_EMERGING_tmp((i-1)*17+1:i*17,1)=(x_EMERGING((i-1)*134+1:i*134,1)'*Class_EMERGING)';
end
%合并国家
z_EMERGING_new=zeros(5*17,5*17);
x_EMERGING_new=zeros(5*17,1);
f_EMERGING_new=zeros(5*17,5);
va_EMERGING_new=zeros(1,5*17);
for i=1:245
    for j=1:245
        z_EMERGING_new((Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17,(Region_EMERGING(j)+6-1)*17+1:(Region_EMERGING(j)+6)*17)=z_EMERGING_new((Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17,(Region_EMERGING(j)+6-1)*17+1:(Region_EMERGING(j)+6)*17)+...
            z_EMERGING_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17);
        f_EMERGING_new((Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17,Region_EMERGING(j)+6)=f_EMERGING_new((Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17,Region_EMERGING(j)+6)+...
            f_EMERGING_tmp((i-1)*17+1:i*17,j);
    end
    x_EMERGING_new((Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17,1)=x_EMERGING_new((Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17,1)+...
            x_EMERGING_tmp((i-1)*17+1:i*17,1);
    va_EMERGING_new(1,(Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17)=va_EMERGING_new(1,(Region_EMERGING(i)+6-1)*17+1:(Region_EMERGING(i)+6)*17)+...
            va_EMERGING_tmp(1,(i-1)*17+1:i*17);
end

%%
EXIOBASE=load(['/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/EXIOBASE_3rx_2015.mat'],'-mat'); 
x_EXIOBASE=EXIOBASE.IO.x; 
A_EXIOBASE=EXIOBASE.IO.A;
z_EXIOBASE=A_EXIOBASE.*x_EXIOBASE';
f_EXIOBASE=EXIOBASE.IO.Y;
va_EXIOBASE=sum(EXIOBASE.IO.V);
%整合 VA Z F X
%合并部门
for i=1:214
    for j=1:214
       z_EXIOBASE_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17)=Class_EXIOBASE'*z_EXIOBASE((i-1)*200+1:i*200,(j-1)*200+1:j*200)*Class_EXIOBASE;
       f_EXIOBASE_tmp((j-1)*17+1:j*17,i)=(sum(f_EXIOBASE((j-1)*200+1:j*200,(i-1)*7+1:i*7),2)'*Class_EXIOBASE)';
    end
    va_EXIOBASE_tmp(1,(i-1)*17+1:i*17)=va_EXIOBASE(1,(i-1)*200+1:i*200)*Class_EXIOBASE;
    x_EXIOBASE_tmp((i-1)*17+1:i*17,1)=(x_EXIOBASE((i-1)*200+1:i*200,1)'*Class_EXIOBASE)';
end
%合并国家
z_EXIOBASE_new=zeros(5*17,5*17);
x_EXIOBASE_new=zeros(5*17,1);
f_EXIOBASE_new=zeros(5*17,5);
va_EXIOBASE_new=zeros(1,5*17);
for i=1:214
    for j=1:214
        z_EXIOBASE_new((Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17,(Region_EXIOBASE(j)+6-1)*17+1:(Region_EXIOBASE(j)+6)*17)=z_EXIOBASE_new((Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17,(Region_EXIOBASE(j)+6-1)*17+1:(Region_EXIOBASE(j)+6)*17)+...
            z_EXIOBASE_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17);
        f_EXIOBASE_new((Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17,Region_EXIOBASE(j)+6)=f_EXIOBASE_new((Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17,Region_EXIOBASE(j)+6)+...
            f_EXIOBASE_tmp((i-1)*17+1:i*17,j);
    end
    x_EXIOBASE_new((Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17,1)=x_EXIOBASE_new((Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17,1)+...
            x_EXIOBASE_tmp((i-1)*17+1:i*17,1);
    va_EXIOBASE_new(1,(Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17)=va_EXIOBASE_new(1,(Region_EXIOBASE(i)+6-1)*17+1:(Region_EXIOBASE(i)+6)*17)+...
            va_EXIOBASE_tmp(1,(i-1)*17+1:i*17);
end

%%
GTAP=load(['/Users/jingwen/OneDrive/GTAPv10_mrio_2014/MRIO2014_V10.mat'],'-mat');
EIO_SAM_2014=GTAP.EIO_SAM;  
x_GTAP=sum(EIO_SAM_2014,2);
f_GTAP=EIO_SAM_2014(1:141*65,141*65+1:141*65+141*3);
z_GTAP=EIO_SAM_2014(1:141*65,1:141*65);
va_GTAP=x_GTAP'-sum(z_GTAP);

%整合 VA Z F X
%合并部门
for i=1:141
    for j=1:141
       z_GTAP_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17)=Class_GTAP'*z_GTAP((i-1)*65+1:i*65,(j-1)*65+1:j*65)*Class_GTAP;
       f_GTAP_tmp((j-1)*17+1:j*17,i)=(sum(f_GTAP((j-1)*65+1:j*65,i:141:end),2)'*Class_GTAP)';
    end
    va_GTAP_tmp(1,(i-1)*17+1:i*17)=va_GTAP(1,(i-1)*65+1:i*65)*Class_GTAP;
    x_GTAP_tmp((i-1)*17+1:i*17,1)=(x_GTAP((i-1)*65+1:i*65,1)'*Class_GTAP)';
end
%合并国家
z_GTAP_new=zeros(5*17,5*17);
x_GTAP_new=zeros(5*17,1);
f_GTAP_new=zeros(5*17,5);
va_GTAP_new=zeros(1,5*17);
for i=1:141
    for j=1:141
        z_GTAP_new((Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17,(Region_GTAP(j)+6-1)*17+1:(Region_GTAP(j)+6)*17)=z_GTAP_new((Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17,(Region_GTAP(j)+6-1)*17+1:(Region_GTAP(j)+6)*17)+...
            z_GTAP_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17);
        f_GTAP_new((Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17,Region_GTAP(j)+6)=f_GTAP_new((Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17,Region_GTAP(j)+6)+...
            f_GTAP_tmp((i-1)*17+1:i*17,j);
    end
    x_GTAP_new((Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17,1)=x_GTAP_new((Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17,1)+...
            x_GTAP_tmp((i-1)*17+1:i*17,1);
    va_GTAP_new(1,(Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17)=va_GTAP_new(1,(Region_GTAP(i)+6-1)*17+1:(Region_GTAP(i)+6)*17)+...
            va_GTAP_tmp(1,(i-1)*17+1:i*17);
end

%%
z_Eora=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_T.txt');
f_Eora=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_FD.txt');
VA=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_VA.txt');
va_Eora=sum(VA,1);
x_Eora=(sum(z_Eora,1)+va_Eora)';

%整合 VA Z F X
%合并部门
for i=1:189
    for j=1:189
       z_Eora_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17)=Class_Eora'*z_Eora((i-1)*26+1:i*26,(j-1)*26+1:j*26)*Class_Eora;
       f_Eora_tmp((j-1)*17+1:j*17,i)=(sum(f_Eora((j-1)*26+1:j*26,(i-1)*6+1:(i-1)*6+6),2)'*Class_Eora)';
    end
    va_Eora_tmp(1,(i-1)*17+1:i*17)=va_Eora(1,(i-1)*26+1:i*26)*Class_Eora;
    x_Eora_tmp((i-1)*17+1:i*17,1)=(x_Eora((i-1)*26+1:i*26,1)'*Class_Eora)';
end
%合并国家
z_Eora_new=zeros(5*17,5*17);
x_Eora_new=zeros(5*17,1);
f_Eora_new=zeros(5*17,5);
va_Eora_new=zeros(1,5*17);
for i=1:189
    for j=1:189
        z_Eora_new((Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17,(Region_Eora(j)+6-1)*17+1:(Region_Eora(j)+6)*17)=z_Eora_new((Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17,(Region_Eora(j)+6-1)*17+1:(Region_Eora(j)+6)*17)+...
            z_Eora_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17);
        f_Eora_new((Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17,Region_Eora(j)+6)=f_Eora_new((Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17,Region_Eora(j)+6)+...
            f_Eora_tmp((i-1)*17+1:i*17,j);
    end
    x_Eora_new((Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17,1)=x_Eora_new((Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17,1)+...
            x_Eora_tmp((i-1)*17+1:i*17,1);
    va_Eora_new(1,(Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17)=va_Eora_new(1,(Region_Eora(i)+6-1)*17+1:(Region_Eora(i)+6)*17)+...
            va_Eora_tmp(1,(i-1)*17+1:i*17);
end

%%
MRIO_OECD=xlsread(['/Users/jingwen/OneDrive/MRIO_Method/Validation/OECD_2015.xlsx']);
z_OECD=MRIO_OECD(1:69*36,1:69*36);  
x_OECD=MRIO_OECD(1:69*36,end);  
va_OECD=MRIO_OECD(end-1,1:69*36);

f_tmp=MRIO_OECD(1:69*36,69*36+1:69*36+65*6); %将tmp Mexio和China
f_OECD=zeros(69*36,69*6);
for i=1:65
    if i==23
        ratio1=x_OECD((66-1)*36+1:66*36,1)./(x_OECD((66-1)*36+1:66*36,1)+x_OECD((67-1)*36+1:67*36,1));
        ratio2=x_OECD((67-1)*36+1:67*36,1)./(x_OECD((66-1)*36+1:66*36,1)+x_OECD((67-1)*36+1:67*36,1));
        ratio1(isnan(ratio1))=0;
        ratio1(isinf(ratio1))=0;
        ratio2(isnan(ratio2))=0;
        ratio2(isinf(ratio2))=0;
        for j=1:65
          f_OECD((j-1)*36+1:j*36,(66-1)*6+1:66*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio1;
          f_OECD((j-1)*36+1:j*36,(67-1)*6+1:67*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio2;
        end
        f_OECD(:,(i-1)*6+1:i*6)=0;
    elseif i==42
        ratio1=x_OECD((68-1)*36+1:68*36,1)./(x_OECD((68-1)*36+1:68*36,1)+x_OECD((69-1)*36+1:69*36,1));
        ratio2=x_OECD((69-1)*36+1:69*36,1)./(x_OECD((68-1)*36+1:68*36,1)+x_OECD((69-1)*36+1:69*36,1));
        ratio1(isnan(ratio1))=0;
        ratio1(isinf(ratio1))=0;
        ratio2(isnan(ratio2))=0;
        ratio2(isinf(ratio2))=0;
        for j=1:65
          f_OECD((j-1)*36+1:j*36,(68-1)*6+1:68*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio1;
          f_OECD((j-1)*36+1:j*36,(69-1)*6+1:69*6)=f_tmp((j-1)*36+1:j*36,(i-1)*6+1:i*6).*ratio2;
        end
        f_OECD(:,(i-1)*6+1:i*6)=0;
    else
        f_OECD(:,(i-1)*6+1:i*6)=f_tmp(:,(i-1)*6+1:i*6);
    end  
end

%整合 VA Z F X
%合并部门
for i=1:69
    for j=1:69
       z_OECD_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17)=Class_OECD'*z_OECD((i-1)*36+1:i*36,(j-1)*36+1:j*36)*Class_OECD;
       f_OECD_tmp((j-1)*17+1:j*17,i)=(sum(f_OECD((j-1)*36+1:j*36,(i-1)*6+1:(i-1)*6+6),2)'*Class_OECD)';
    end
    va_OECD_tmp(1,(i-1)*17+1:i*17)=va_OECD(1,(i-1)*36+1:i*36)*Class_OECD;
    x_OECD_tmp((i-1)*17+1:i*17,1)=(x_OECD((i-1)*36+1:i*36,1)'*Class_OECD)';
end
%合并国家
z_OECD_new=zeros(5*17,5*17);
x_OECD_new=zeros(5*17,1);
f_OECD_new=zeros(5*17,5);
va_OECD_new=zeros(1,5*17);
for i=1:69
    for j=1:69
        z_OECD_new((Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17,(Region_OECD(j)+6-1)*17+1:(Region_OECD(j)+6)*17)=z_OECD_new((Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17,(Region_OECD(j)+6-1)*17+1:(Region_OECD(j)+6)*17)+...
            z_OECD_tmp((i-1)*17+1:i*17,(j-1)*17+1:j*17);
        f_OECD_new((Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17,Region_OECD(j)+6)=f_OECD_new((Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17,Region_OECD(j)+6)+...
            f_OECD_tmp((i-1)*17+1:i*17,j);
    end
    x_OECD_new((Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17,1)=x_OECD_new((Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17,1)+...
            x_OECD_tmp((i-1)*17+1:i*17,1);
    va_OECD_new(1,(Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17)=va_OECD_new(1,(Region_OECD(i)+6-1)*17+1:(Region_OECD(i)+6)*17)+...
            va_OECD_tmp(1,(i-1)*17+1:i*17);
end
z_Eora_new=z_Eora_new./1000;
va_Eora_new=va_Eora_new./1000;
x_Eora_new=x_Eora_new./1000;
f_Eora_new=f_Eora_new./1000;

A_EMERGING=z_EMERGING_new./x_EMERGING_new';
A_EMERGING(isnan(A_EMERGING))=0;
A_EMERGING(isinf(A_EMERGING))=0;

I=eye(size(A_EMERGING));
L_EMERGING=(I-A_EMERGING)^-1;
X_EMERGING=L_EMERGING*sum(f_EMERGING_new,2);
S_EMERGING=va_EMERGING_new./x_EMERGING_new';
S_EMERGING(isnan(S_EMERGING))=0;
S_EMERGING(isinf(S_EMERGING))=0;
VAA_EMERGING=S_EMERGING*L_EMERGING*f_EMERGING_new;

A_EXIOBASE=z_EXIOBASE_new./x_EXIOBASE_new';
A_EXIOBASE(isnan(A_EXIOBASE))=0;
A_EXIOBASE(isinf(A_EXIOBASE))=0;

I=eye(size(A_EXIOBASE));
L_EXIOBASE=(I-A_EXIOBASE)^-1;
X_EXIOBASE=L_EXIOBASE*sum(f_EXIOBASE_new,2);
S_EXIOBASE=va_EXIOBASE_new./x_EXIOBASE_new';
S_EXIOBASE(isnan(S_EXIOBASE))=0;
S_EXIOBASE(isinf(S_EXIOBASE))=0;
VAA_EXIOBASE=S_EXIOBASE*L_EXIOBASE*f_EXIOBASE_new;

A_Eora=z_Eora_new./x_Eora_new';
A_Eora(isnan(A_Eora))=0;
A_Eora(isinf(A_Eora))=0;

I=eye(size(A_Eora));
L_Eora=(I-A_Eora)^-1;
X_Eora=L_Eora*sum(f_Eora_new,2);
S_Eora=va_Eora_new./x_Eora_new';
S_Eora(isnan(S_Eora))=0;
S_Eora(isinf(S_Eora))=0;
VAA_Eora=S_Eora*L_Eora*f_Eora_new;

A_GTAP=z_GTAP_new./x_GTAP_new';
A_GTAP(isnan(A_GTAP))=0;
A_GTAP(isinf(A_GTAP))=0;

I=eye(size(A_GTAP));
L_GTAP=(I-A_GTAP)^-1;
X_GTAP=L_GTAP*sum(f_GTAP_new,2);
S_GTAP=va_GTAP_new./x_GTAP_new';
S_GTAP(isnan(S_GTAP))=0;
S_GTAP(isinf(S_GTAP))=0;
VAA_GTAP=S_GTAP*L_GTAP*f_GTAP_new;

A_OECD=z_OECD_new./x_OECD_new';
A_OECD(isnan(A_OECD))=0;
A_OECD(isinf(A_OECD))=0;

I=eye(size(A_OECD));
L_OECD=(I-A_OECD)^-1;
X_OECD=L_OECD*sum(f_OECD_new,2);
S_OECD=va_OECD_new./x_OECD_new';
S_OECD(isnan(S_OECD))=0;
S_OECD(isinf(S_OECD))=0;
VAA_OECD=S_OECD*L_OECD*f_OECD_new;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SDA

dVA1=S_EMERGING-S_EXIOBASE;
dVA2=S_EMERGING-S_Eora;
dVA3=S_EMERGING-S_GTAP;
dVA4=S_EMERGING-S_OECD;

dL1=L_EMERGING-L_EXIOBASE;
dL2=L_EMERGING-L_Eora;
dL3=L_EMERGING-L_GTAP;
dL4=L_EMERGING-L_OECD;

dF1=f_EMERGING_new-f_EXIOBASE_new;
dF2=f_EMERGING_new-f_Eora_new;
dF3=f_EMERGING_new-f_GTAP_new;
dF4=f_EMERGING_new-f_OECD_new;


ddVA1=zeros(1,5);
ddVA2=zeros(1,5);
for i=1:5
    ddVA1(:,i)=dVA1*L_EMERGING*f_EMERGING_new(:,i);
    ddVA2(:,i)=dVA1*L_EXIOBASE*f_EXIOBASE_new(:,i);
end

ddL1=zeros(1,5);
ddL2=zeros(1,5);
for i=1:5
    ddL1(:,i)=S_EXIOBASE*dL1*f_EMERGING_new(:,i);
    ddL2(:,i)=S_EMERGING*dL1*f_EXIOBASE_new(:,i);
end

ddF1=zeros(1,5);
ddF2=zeros(1,5);
for i=1:5
    ddF1(:,i)=S_EXIOBASE*L_EXIOBASE*dF1(:,i);
    ddF2(:,i)=S_EMERGING*L_EMERGING*dF1(:,i);
end

S_F=(ddVA1+ddVA2)/2;
L_F=(ddL1+ddL2)/2;
F_F=(ddF1+ddF2)/2;

IDA1=[S_F',L_F',F_F',VAA_EMERGING'-VAA_EXIOBASE'];
%%
ddVA1=zeros(1,5);
ddVA2=zeros(1,5);
for i=1:5
    ddVA1(:,i)=dVA2*L_EMERGING*f_EMERGING_new(:,i);
    ddVA2(:,i)=dVA2*L_Eora*f_Eora_new(:,i);
end

ddL1=zeros(1,5);
ddL2=zeros(1,5);
for i=1:5
    ddL1(:,i)=S_Eora*dL2*f_EMERGING_new(:,i);
    ddL2(:,i)=S_EMERGING*dL2*f_Eora_new(:,i);
end

ddF1=zeros(1,5);
ddF2=zeros(1,5);
for i=1:5
    ddF1(:,i)=S_Eora*L_Eora*dF2(:,i);
    ddF2(:,i)=S_EMERGING*L_EMERGING*dF2(:,i);
end

S_F=(ddVA1+ddVA2)/2;
L_F=(ddL1+ddL2)/2;
F_F=(ddF1+ddF2)/2;

IDA2=[S_F',L_F',F_F',VAA_EMERGING'-VAA_Eora'];

%%
ddVA1=zeros(1,5);
ddVA2=zeros(1,5);
for i=1:5
    ddVA1(:,i)=dVA3*L_EMERGING*f_EMERGING_new(:,i);
    ddVA2(:,i)=dVA3*L_GTAP*f_GTAP_new(:,i);
end

ddL1=zeros(1,5);
ddL2=zeros(1,5);
for i=1:5
    ddL1(:,i)=S_GTAP*dL3*f_EMERGING_new(:,i);
    ddL2(:,i)=S_EMERGING*dL3*f_GTAP_new(:,i);
end

ddF1=zeros(1,5);
ddF2=zeros(1,5);
for i=1:5
    ddF1(:,i)=S_GTAP*L_GTAP*dF3(:,i);
    ddF2(:,i)=S_EMERGING*L_EMERGING*dF3(:,i);
end

S_F=(ddVA1+ddVA2)/2;
L_F=(ddL1+ddL2)/2;
F_F=(ddF1+ddF2)/2;

IDA3=[S_F',L_F',F_F',VAA_EMERGING'-VAA_GTAP'];
%%
ddVA1=zeros(1,5);
ddVA2=zeros(1,5);
for i=1:5
    ddVA1(:,i)=dVA4*L_EMERGING*f_EMERGING_new(:,i);
    ddVA2(:,i)=dVA4*L_OECD*f_OECD_new(:,i);
end

ddL1=zeros(1,5);
ddL2=zeros(1,5);
for i=1:5
    ddL1(:,i)=S_OECD*dL4*f_EMERGING_new(:,i);
    ddL2(:,i)=S_EMERGING*dL4*f_OECD_new(:,i);
end

ddF1=zeros(1,5);
ddF2=zeros(1,5);
for i=1:5
    ddF1(:,i)=S_OECD*L_OECD*dF4(:,i);
    ddF2(:,i)=S_EMERGING*L_EMERGING*dF4(:,i);
end

S_F=(ddVA1+ddVA2)/2;
L_F=(ddL1+ddL2)/2;
F_F=(ddF1+ddF2)/2;

IDA4=[S_F',L_F',F_F',VAA_EMERGING'-VAA_OECD'];

toc