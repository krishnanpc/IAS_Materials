clear;clc;

separation=1.0;
Class1Size=[20 100 300 400 500];
Class2Size=[20 100 300 400 500];
for n1=Class1Size
    for n2=Class2Size
        train_data_class1 = rand(n1,2);
        train_data_class2 = rand(n2,2) + ones(n2,2)*[separation 0; 0 0];
        train_data = [train_data_class1 ; train_data_class2];
        train_label=[];
        train_label(1:n1) = 1;
        train_label(n1+1:n1+n2) = 2;
                
        n3 = 100; test_data_class1 = rand(n3,2);
        n4 = 100; test_data_class2 = rand(n4,2) + ones(n4,2)*[separation 0; 0 0];
        test_data = [test_data_class1 ; test_data_class2];
        test_label=[];
        test_label(1:n3) = 1;
        test_label(n4+1:n3+n4) = 2;
        
        k_values=[1, 3, 5, 7, 10, 15, 20];
        errTrain=zeros(1,length(k_values));
        errTest=zeros(1,length(k_values));
        
        for i = 1:length(k_values)
            YDashTrain=KNN(train_data,train_label',train_data,k_values(i));
            errTrain(i)=empiricalRisk(train_label',YDashTrain');
            
            YDashTest=KNN(train_data,train_label',test_data,k_values(i));
            errTest(i)=empiricalRisk(test_label',YDashTest');            
        end
        figure;hold on;
        plot(k_values,errTrain,'r*:');
        plot(k_values,errTest, 'b.-');
        hold off;
        
    end
end