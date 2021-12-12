IEA_CO2=xlsread('/Users/jingwen/OneDrive/EMERGING_CO2/IEA_CO2_2015.xlsx','data_GTAP');
IEA_CO2(isnan(IEA_CO2))=0;

MRIOT2014=load(['/Users/jingwen/OneDrive/GTAPv10_mrio_2014/MRIO2014_V10.mat'],'-mat');
EIO_SAM_2014=MRIOT2014.EIO_SAM;  

X_T=sum(EIO_SAM_2014,2); %134

X_=zeros(141*3,65);
for i=1:141 %用全部的对i国的能源投入看 竞争表
    X_((i-1)*3+1,:)=sum(EIO_SAM_2014(15:65:end,(i-1)*65+1:i*65),1);
    X_((i-1)*3+2,:)=sum(EIO_SAM_2014(16:65:end,(i-1)*65+1:i*65),1);
    X_((i-1)*3+3,:)=sum(EIO_SAM_2014(17:65:end,(i-1)*65+1:i*65),1);
end
X=zeros(141*65,3);
for i=1:141
   X((i-1)*65+1:i*65,:)=X_((i-1)*3+1:i*3,:)';
end

X_ratio_map=xlsread('/Users/jingwen/OneDrive/EMERGING_CO2/input_102_105.xlsx','map_S_GTAP'); %65
X_ratio_map=[X_ratio_map(:,1),X_ratio_map(:,3)];


IEA_Sector_matrix=xlsread('/Users/jingwen/OneDrive/EMERGING_CO2/IEA_CO2_2015.xlsx','S_map_GTAP');
IEA_Sector_matrix=IEA_Sector_matrix(3:end,:);

IEA_Region_map=xlsread('/Users/jingwen/OneDrive/EMERGING_CO2/IEA_CO2_2015.xlsx','R_map_GTAP'); %分了5大洲 需要减去有数据的国家
IEA_Region_map=[IEA_Region_map(:,1),IEA_Region_map(:,5)];
%%
% 整理IEA的数据
CO2_IEA=zeros(141*65,7); 
IEA_7=zeros(141*31,7);
%单个国家
for i=1:141
    IEA_i=IEA_CO2(find(IEA_CO2(:,1)==i),:);
    if length(IEA_i)==0
        continue;
    else
      IEA_i_7=zeros(31,7); %首先整理一下能源品种i
      for j=1:7
          for k=1:31
             S_I=find(IEA_i(:,4)==j & IEA_i(:,7)==k);
             IEA_i_7(k,j)=sum(IEA_i(S_I,9));
          end
      end
      IEA_7((i-1)*31+1:i*31,:)=IEA_i_7;
      %拆到65个部门 拆分比例用能源使用量
      for j=1:7
          if j==5
              continue;
          end
         X_i_j=X((i-1)*65+1:i*65,X_ratio_map(j,2));
         X_i=sum(X((i-1)*65+1:i*65,:),2);
         X_T_i=X_T((i-1)*65+1:i*65,1);
         result=zeros(65,1);
         for k=1:31
            S_I=IEA_Sector_matrix(find(IEA_Sector_matrix(:,k+1)==1),1);
            ratio=X_i_j(S_I,1)./sum(X_i_j(S_I,1));
            ratio(isnan(ratio))=0;
            if sum(ratio)==0 %必须保证拆分比例不为0 如果是0 那用能源总比例拆 
                ratio=X_i(S_I,1)./sum(X_i(S_I,1));
                ratio(isnan(ratio))=0;
            end
            if sum(ratio)==0 %如果总比例也是0 那就用总ouput拆
                ratio=X_T_i(S_I,1)./sum(X_T_i(S_I,1));
                ratio(isnan(ratio))=0;
            end
            result(S_I,1)=result(S_I,1)+IEA_i_7(k,j).*ratio;
         end
         CO2_IEA((i-1)*65+1:i*65,j)=result;
      end
    end
end
%% 区域拆分 5个大区域 南极洲为0
Region_CO2=zeros(6*31,7);
for i=-5:-1
    IEA_R=IEA_CO2(find(IEA_CO2(:,1)==i),:);
    if length(IEA_R)==0
        continue;
    else
      IEA_R_7=zeros(31,7); %首先整理一下能源品种i
      for j=1:7
          for k=1:31
             S_I=find(IEA_R(:,4)==j & IEA_R(:,7)==k);
             IEA_R_7(k,j)=sum(IEA_R(S_I,9));
          end
      end
      %修改区域总量
      R_i=find(IEA_Region_map(:,2)==i);
      E_total=zeros(length(R_i),1);
      for g=1:length(R_i)
          IEA_i=IEA_CO2(find(IEA_CO2(:,1)==R_i(g)),:);
          if length(IEA_i)==0
              E_total(g,1)=sum(sum(X((R_i(g)-1)*65+1:R_i(g)*65,:)));
              continue;
          else
             IEA_R_7=IEA_R_7-IEA_7((R_i(g)-1)*31+1:R_i(g)*31,:);
          end 
      end
      IEA_R_7(IEA_R_7<0)=0;
      Region_CO2((i+6-1)*31+1:(i+6)*31,:)=IEA_R_7;
      %拆到65个部门 拆分比例用能源使用量
      Index_R_C=IEA_Region_map(find(IEA_Region_map(:,2)==i),1);
      for h=1:length(Index_R_C)
         T= sum(sum(CO2_IEA((Index_R_C(h)-1)*65+1:Index_R_C(h)*65,:)));
         if T ~=0
             continue;
         else
             IEA_R_C=IEA_R_7.*(E_total(h,1)/sum(E_total));%拆分各个国家的能源 用各个国家总的能源使用量
             IEA_R_C(isnan(IEA_R_C))=0;
         for j=1:7
          if j==5
              continue;
          end
           X_i_j=X((Index_R_C(h)-1)*65+1:Index_R_C(h)*65,X_ratio_map(j,2));
           X_i=sum(X((Index_R_C(h)-1)*65+1:Index_R_C(h)*65,:),2);
           X_T_i=sum(X_T((Index_R_C(h)-1)*65+1:Index_R_C(h)*65,:),2);
           result=zeros(65,1);
           for k=1:31
              S_I=IEA_Sector_matrix(find(IEA_Sector_matrix(:,k+1)==1),1);
              ratio=X_i_j(S_I,1)./sum(X_i_j(S_I,1));
              ratio(isnan(ratio))=0;
              if sum(ratio)==0 %必须保证拆分比例不为0 如果是0 那用能源总比例拆
                ratio=X_i(S_I,1)./sum(X_i(S_I,1));
                ratio(isnan(ratio))=0;
              end
              if sum(ratio)==0 %如果总比例也是0 那就用总ouput拆
                ratio=X_T_i(S_I,1)./sum(X_T_i(S_I,1));
                ratio(isnan(ratio))=0;
              end
              result(S_I,1)=result(S_I,1)+IEA_R_C(k,j).*ratio;
           end
           CO2_IEA((Index_R_C(h)-1)*65+1:Index_R_C(h)*65,j)=result;
         end
         end
      end
    end
end
%%