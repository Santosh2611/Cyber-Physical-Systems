% Defining the function call
tF = 212;
tC = tempF2C(tF);

 % The function name has already been defined and locked for editing to prevent any issues.
 function tempC = tempF2C(tempF)
    tempC = (tempF - 32) / 1.8;    
end