clear;clc;

separation=1.0;
Class1Size=[20];% 100 300 400 500];
Class2Size=[20];% 100 300 400 500];
for n1=Class1Size
    for n2=Class2Size
        train_data_class1 = rand(n1,2);
        train_data_class2 = rand(n2,2) + ones(n2,2)*[separation 0; 0 0];
        train_data = [train_data_class1 ; train_data_class2];
        train_label=[];
        train_label(1:n1) = 1;
        train_label(n1+1:n1+n2) = 2;
        
        %Data Plotting
        %         figure (1); clf; hold all; axis equal;
        %         plot(train_data(1:n1,1), train_data(1:n1,2), 'r*');
        %         plot(train_data(n1+1:n1+n2,1), train_data(n1+1:n1+n2,2), 'bo');
        
        n3 = 100; test_data_class1 = rand(n3,2);
        n4 = 100; test_data_class2 = rand(n4,2) + ones(n4,2)*[separation 0; 0 0];
        test_data = [test_data_class1 ; test_data_class2];
        test_label=[];
        test_label(1:n3) = 1;
        test_label(n4+1:n3+n4) = 2;
        
        %Test Data Plotting
        %         figure (1); clf; hold all; axis equal;
        %         plot(test_data(1:n3,1), test_data(1:n3,2), 'r*');
        %         plot(test_data(n3+1:n3+n4,1), test_data(n3+1:n3+n4,2), 'bo');
        
        k_values=[1, 3, 5, 7, 10, 15, 20];
        errTrain=zeros(1,length(k_values));
        errTest=zeros(1,length(k_values));
        
        for i = 1:length(k_values)
            YDashTrain=KNNVectorized(train_data,train_label',train_data,k_values(i));
            errTrain(i)=empiricalRisk(train_label',YDashTrain');
            
            YDashTest=KNNVectorized(train_data,train_label',test_data,k_values(i));
            errTest(i)=empiricalRisk(test_label',YDashTest');
        end
        
        %Plot error
        %         figure;hold on;
        %         plot(k_values,errTrain,'r*:');
        %         plot(k_values,errTest, 'b.-');
        %         hold off;
        %         figure(3); clf; hold all; axis equal;
        %         pred_class1 = find(YDashTest==1);
        %         pred_class2 = find(YDashTest==2);
        %         plot(test_data(pred_class1,1),test_data(pred_class1,2),'r*');
        %         plot(test_data(pred_class2,1),test_data(pred_class2,2),'bo');
        %         plot([1 1],[0 1],'k')
    end
end