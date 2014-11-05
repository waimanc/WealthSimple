%%%%%%%% Run TLH for combinations of threshold %%%%%%%%%%

%%%%% 2 asset model - VTI and CBO.TO
assetReturns = [fts2mat(VTI_CBO_returns.VTI) fts2mat(VTI_CBO_returns.CBO)];

initialDeposit = 100000;
initialWeights = [0.7;0.3];

thresholds = 0.02:0.005:0.2;

taxRate = 0.5*(0.29 + 0.1316);
taxRateEnd = 0.1;

AfterTaxGain = nan(length(thresholds));
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0 0];

for i = 1:length(thresholds)
    for j = 1:length(thresholds)
        [AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]     = TLH(assetReturns,initialDeposit,initialWeights,...
                                                    [thresholds(i);thresholds(j)],taxRate,taxRateEnd);
                                                
        AfterTaxGain(i,j) = AfterTaxGrowth;
        
        if AfterTaxGain(i,j) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i,j);
            currOptimalThreshold(1) = thresholds(i);
            currOptimalThreshold(2) = thresholds(j);
            
        end
    end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
          PortfolioEndValue EndCapitalGainsTax...
          HarvestedDates HarvestedAmounts]     = TLH(assetReturns,initialDeposit,initialWeights,...
                                                    [currOptimalThreshold(1);currOptimalThreshold(2)],taxRate,taxRateEnd);
%%%%% 4 asset model
FinancialSeriesCellArray = cell(4,1);
FinancialSeriesCellArray{1} = VTI;
FinancialSeriesCellArray{2} = CBO;
FinancialSeriesCellArray{3} = XIC;
FinancialSeriesCellArray{4} = XHY;

[assetReturns] = calculateReturns(FinancialSeriesCellArray);
RetSeries = [fts2mat(assetReturns.VTI) fts2mat(assetReturns.CBO) fts2mat(assetReturns.XHY) fts2mat(assetReturns.XIC)];

weights = [0.25 0.25 0.25 0.25]';
taxRate = 0.5*(0.29 + 0.1316);
taxRateEnd = 0.1;

Thresholds = 0.05:0.01:0.20;
N = length(Thresholds);

currMaxAfterTaxGrowth = -Inf;
currOptimalThreshold = [0 0 0 0]';

for i = 1:N
for j = 1:N
for k = 1:N
for l = 1:N
    [AssetEndValues Harvested_Amount_Growth...
     EndCapitalGainsTax Harvested_AmountAnnual HarvestedDates] = TLH(RetSeries,100000,weights,[Thresholds(i);Thresholds(j);Thresholds(k);Thresholds(l)],taxRate,taxRateEnd);
     
     AfterTaxGrowth = AssetEndValues - 100000 - EndCapitalGainsTax + Harvested_Amount_Growth;
     
     if AfterTaxGrowth > currMaxAfterTaxGrowth
         currMaxAfterTaxGrowth = AfterTaxGrowth;
         currOptimalThreshold(1) = Thresholds(i);
         currOptimalThreshold(2) = Thresholds(j);
         currOptimalThreshold(3) = Thresholds(k);
         currOptimalThreshold(4) = Thresholds(l);
     end
                
end
end
end
end

[AssetEndValues Harvested_Amount_Growth...
 EndCapitalGainsTax Harvested_AmountAnnual HarvestedDates] = TLH(assetReturns,100000,weights,currOptimalThreshold,taxRate,taxRateEnd);













