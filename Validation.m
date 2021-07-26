clear all;  %清变量
clc;    %清屏

GAP_data=xlsread('D:\OneDrive\MRIO_Method\VA_FOOT_new.xlsx','全部国家'); %发展中国家_除中国印度

reulst_C(:,1)=(GAP_data(:,4)-GAP_data(:,3))./GAP_data(:,4).*100;
reulst_C(:,2)=(GAP_data(:,4)-GAP_data(:,5).*5)./GAP_data(:,4).*100;
reulst_C(:,3)=(GAP_data(:,4)-GAP_data(:,6)./1000)./GAP_data(:,4).*100;
reulst_P(:,1)=(GAP_data(:,10)-GAP_data(:,9))./GAP_data(:,10).*100;
reulst_P(:,2)=(GAP_data(:,10)-GAP_data(:,11).*5)./GAP_data(:,10).*100;
reulst_P(:,3)=(GAP_data(:,10)-GAP_data(:,12)./1000)./GAP_data(:,10).*100;

GAP_C=zeros(115,1);
GAP_P=zeros(115,1);
X1=GAP_data(:,7)./1000;
X2=GAP_data(:,13)./1000;

figure(1)
for i=1:115
    A=min(abs(reulst_C(i,:)));
    if abs(reulst_C(i,1))==A
        plot(X1(i,1),reulst_C(i,1),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
      % text(X1(i,1),reulst_C(i,1),num2str(i))
     %   ylim([-40 40])
        hold on;
    elseif abs(reulst_C(i,2))==A
        plot(X1(i,1),reulst_C(i,2),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
     % text(X1(i,1),reulst_C(i,2),num2str(i))
      %  ylim([-40 40])
        hold on;
    else
        plot(X1(i,1),reulst_C(i,3),'o','MarkerSize',5,'MarkerFaceColor','c','MarkerEdgeColor','c');
     % text(X1(i,1),reulst_C(i,3),num2str(i))
      % ylim([-40 40])
        hold on;
    end
end

figure(2)
for i=1:115
    A=min(abs(reulst_P(i,:)));
    if abs(reulst_P(i,1))==A
        plot(X2(i,1),reulst_P(i,1),'o','MarkerSize',5,'MarkerFaceColor','r','MarkerEdgeColor','r');
       %text(X2(i,1),reulst_P(i,1),num2str(i))
     %  xlim([0 250])
        hold on;
    elseif abs(reulst_P(i,2))==A
        plot(X2(i,1),reulst_P(i,2),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
      %text(X2(i,1),reulst_P(i,2),num2str(i))
     % xlim([0 250])
        hold on;
    else
        plot(X2(i,1),reulst_P(i,3),'o','MarkerSize',5,'MarkerFaceColor','c','MarkerEdgeColor','c');
      %text(X2(i,1),reulst_P(i,3),num2str(i))
     % xlim([0 250])
        hold on;
    end
end
