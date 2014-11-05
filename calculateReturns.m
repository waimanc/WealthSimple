%% calculate log-returns for the assets in the FinancialSeries cell array, 
%% keepinp only intersected dates.
function [assetReturns] = calculateReturns(FinancialSeriesCellArray)

numAssets = length(FinancialSeriesCellArray);

for i = 1:numAssets
    returns = log(FinancialSeriesCellArray{i} ./ lagts(FinancialSeriesCellArray{i},1));
    returns = returns(2:end);    
    
    if i == 1
        assetReturns = returns;
    else
        assetReturns = merge(assetReturns,returns,'DateSetMethod','Intersection');
    end
end


end