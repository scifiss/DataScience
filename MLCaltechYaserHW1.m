% Week 1 Homework q7-10 for the ML course @EdX by Yaser Abu-Mostafa from CalTech: Perceptron
clear, close all
N=10;
Nrun=1000;
niter = zeros(Nrun,1);
nfneg = zeros(Nrun,1);
x =-1+2* rand(N,2);
for irun=1:Nrun
    
    %x1=x(:,1) x2=x(:,2)
    %y = Kx + y1-Kx1
    ptarget = -1+2*rand(2,2);    
    k = (ptarget(2,2)-ptarget(1,2))/(ptarget(2,1)-ptarget(1,1));  %k ~= 0 or nan
    b = ptarget(1,2)-k*ptarget(1,1);
    funTarget =@(x) k*x+b;
    classTarget = sign(x(:,2)-funTarget(x(:,1)));  % need handle if points lie on line
    
    % figure(1),plot(x(:,1),x(:,2),'b.');
    % xlim([-1 1])
    % ylim([-1 1])
    % hold on
    % line([-1 1],funTarget([-1 1]),'Color','g'),       
    w = zeros(1,size(x,2)+1);
    X = [ones(size(x,1),1) x];
    iter=0;
    while iter<1000
        h = sign( w*X')';
        wrongy = h~=classTarget;
        if sum(wrongy)==0
            break;
        end
        inew = randperm(N);
        for i=1:N
            if wrongy(inew(i))==1
                w = w+ classTarget(inew(i))*X(inew(i),:);
                break;
            end
        end
        iter = iter+1;
    end
    niter(irun)=iter;
    kh = -w(2)/w(3);
    bh = -w(1)/w(3);
    funResult = @(x) kh*x+bh;
    % line([-1 1],funResult([-1 1]),'Color','r'),
    % hold off  
    nfneg(irun)=sum(wrongy)>0;    
end
mean(niter)
mean(nfneg)
