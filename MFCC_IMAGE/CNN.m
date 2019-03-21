clear all;clc;

%% 

layer_c1_num=20;
layer_s1_num=20;
layer_f1_num=100;
layer_output_num=10;

yita=0.01;

bias_c1=(2*rand(1,20)-ones(1,20))/sqrt(20);
bias_f1=(2*rand(1,100)-ones(1,100))/sqrt(20);

[kernel_c1,kernel_f1]=init_kernel(layer_c1_num,layer_f1_num);

pooling_a=ones(2,3)/6;

weight_f1=(2*rand(20,100)-ones(20,100))/sqrt(20);
weight_output=(2*rand(100,10)-ones(100,10))/sqrt(100);
disp('neural network initialization completed......');

disp('start neural network training......');
for iter=1:10
for n=1:16
    for m=0:9
       
        train_data=imread(strcat(num2str(m),'_',num2str(n),'.bmp'));
%         a=open(strcat(num2str(m),'_',num2str(n),'.fig'));
%         h=get(gca,'Children');
%         train_data=get(h,'Cdata');
        train_data=double(train_data);
       
        %train_data=wipe_off_average(train_data);
       
        for k=1:layer_c1_num
            state_c1(:,:,k)=convolution(train_data,kernel_c1(:,:,k));
           
            state_c1(:,:,k)=tanh(state_c1(:,:,k)+bias_c1(1,k));
            %pooling1
            state_s1(:,:,k)=pooling(state_c1(:,:,k),pooling_a);
        end
        
        [state_f1_pre,state_f1_temp]=convolution_f1(state_s1,kernel_f1,weight_f1);
        
        for nn=1:layer_f1_num
            state_f1(1,nn)=tanh(state_f1_pre(:,:,nn)+bias_f1(1,nn));
        end
        
        for nn=1:layer_output_num
            output(1,nn)=exp(state_f1*weight_output(:,nn))/sum(exp(state_f1*weight_output));
        end
       
        Error_cost=-output(1,m+1);
%         if (Error_cost<-0.98)
%             break;
%         end
        
        [kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1]=CNN_upweight(yita,Error_cost,m,train_data,...
                                                                                                state_c1,state_s1,...
                                                                                                state_f1,state_f1_temp,...
                                                                                                output,...
                                                                                                kernel_c1,kernel_f1,weight_f1,weight_output,bias_c1,bias_f1);

    end    
end
end
disp('nueral network training completed, start the test......');
count=0;

for n=1:1
    for m=0:9
        
        train_data=imread(strcat('test_',num2str(m),'_',num2str(n),'.bmp'));
%         a=open(strcat(num2str(m),'_',num2str(n),'.fig'));
%         h=get(gca,'Children');
%         train_data=get(h,'Cdata');
        train_data=double(train_data);
       
        %train_data=wipe_off_average(train_data);
       
        for k=1:layer_c1_num
            state_c1(:,:,k)=convolution(train_data,kernel_c1(:,:,k));
            
            state_c1(:,:,k)=tanh(state_c1(:,:,k)+bias_c1(1,k));
            
            state_s1(:,:,k)=pooling(state_c1(:,:,k),pooling_a);
        end
        
        [state_f1_pre,state_f1_temp]=convolution_f1(state_s1,kernel_f1,weight_f1);
        
        for nn=1:layer_f1_num
            state_f1(1,nn)=tanh(state_f1_pre(:,:,nn)+bias_f1(1,nn));
        end
        
        for nn=1:layer_output_num
            output(1,nn)=exp(state_f1*weight_output(:,nn))/sum(exp(state_f1*weight_output));
        end
        [p,classify]=max(output);
        if (classify==m+1)
            count=count+1;
        end
        fprintf('real number is %d    training result is %d    correct rate is %d \n',m,classify-1,p);
    end
end