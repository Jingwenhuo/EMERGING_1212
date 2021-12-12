clear all
clc;    
tic; 

EMERGING=load(['/Users/jingwen/OneDrive/EMERGING_CO2/global_mrio_2015_1102.mat'],'-mat');
X_EMERGING=EMERGING.X;
f_EMERGING=EMERGING.f;
f_EMERGING=abs(f_EMERGING);
C_EMERGING=zeros(245,134);
for i=1:245
    P_EMERGING(i,:)=X_EMERGING((i-1)*134+1:i*134,1)';
    for j=1:245
       C_EMERGING(i,:)=C_EMERGING(i,:)+sum(f_EMERGING((j-1)*134+1:j*134,(i-1)*3+1:i*3),2)';
    end
end

EXIOBASE=load(['/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/EXIOBASE_3rx_2015.mat'],'-mat'); 
X_EXIOBASE=EXIOBASE.IO.x; 
f_EXIOBASE=EXIOBASE.IO.Y;
C_EXIOBASE=zeros(214,200);
for i=1:214
    P_EXIOBASE(i,:)=X_EXIOBASE((i-1)*200+1:i*200,1)';
    for j=1:214
       C_EXIOBASE(i,:)=C_EXIOBASE(i,:)+sum(f_EXIOBASE((j-1)*200+1:j*200,(i-1)*7+1:i*7),2)';
    end
end

GTAP=load(['/Users/jingwen/OneDrive/GTAPv10_mrio_2014/MRIO2014_V10.mat'],'-mat');
EIO_SAM_2014=GTAP.EIO_SAM;  
X_GTAP=sum(EIO_SAM_2014,2);
f_GTAP=EIO_SAM_2014(1:141*65,141*65+1:141*65+141*3);
C_GTAP=zeros(141,65);
for i=1:141
    P_GTAP(i,:)=X_GTAP((i-1)*65+1:i*65,1)';
    for j=1:141
       C_GTAP(i,:)=C_GTAP(i,:)+sum(f_GTAP((j-1)*65+1:j*65,i:141:end),2)';
    end
end

Z_Eora=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_T.txt');
f_Eora=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_FD.txt');
VA_Eora=textread('/Users/jingwen/OneDrive/EMERGING_CO2/EXIO+Eora/Eora MRIO/Eora26_2015_bp_VA.txt');
VA1=sum(VA_Eora,1);
X_Eora=(sum(Z_Eora,1)+VA1)';
C_Eora=zeros(189,26);
for i=1:189
    P_Eora(i,:)=X_Eora((i-1)*26+1:i*26,1)';
    for j=1:189
       C_Eora(i,:)=C_Eora(i,:)+sum(f_Eora((j-1)*26+1:j*26,(i-1)*6+1:(i-1)*6+6),2)';
    end
end

Class_EMERGING=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge EMERGING');
Class_EMERGING(isnan(Class_EMERGING))=0;
Class_EXIOBASE=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge EXIOBASE');
Class_EXIOBASE(isnan(Class_EXIOBASE))=0;
Class_GTAP=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge GTAP');
Class_GTAP(isnan(Class_GTAP))=0;
Class_Eora=xlsread('/Users/jingwen/OneDrive/MRIO_Method/Validation/Sector+list_17.xlsx','Bridge Eora');
Class_Eora(isnan(Class_Eora))=0;

P_EMERGING_17=P_EMERGING*Class_EMERGING;
C_EMERGING_17=C_EMERGING*Class_EMERGING;
P_EXIOBASE_17=P_EXIOBASE*Class_EXIOBASE;
C_EXIOBASE_17=C_EXIOBASE*Class_EXIOBASE;
P_GTAP_17=P_GTAP*Class_GTAP;
C_GTAP_17=C_GTAP*Class_GTAP;
P_Eora_17=P_Eora*Class_Eora;
C_Eora_17=C_Eora*Class_Eora;

toc