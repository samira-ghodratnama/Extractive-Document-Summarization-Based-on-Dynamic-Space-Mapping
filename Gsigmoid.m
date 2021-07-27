function Sprim=Gsigmoid(z,Beta) 
    Sprim=(Beta*exp(Beta*(1-z)))/((1+exp(Beta*(1-z)))^2);
end