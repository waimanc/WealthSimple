%%%%% Run TLH on portfolio of 70% stocks and 30% bonds (no-rebalancing)

initialDeposit = 100000;
horizon = 30*252;
initialWeights = [0.7 0.3]';
taxRate = 0.5*(0.29 + 0.1316);
taxRateEnd = 0.1;

expectedReturns = [0.08 0.04] / 252;
expectedCov     = [0.08^2 0;0 0.04^2] / sqrt(252);

RetSeries = portsim(expectedReturns, expectedCov, horizon, 1, 1, 'Expected');

thresholds = 0.02:0.005:0.2;
AfterTaxGain = nan(length(thresholds),length(thresholds));
currMaxAfterTaxGain = -Inf;
currOptimalThreshold = [0 0]';

for i = 1:length(thresholds)
    for j = 1:length(thresholds)
        
        [AfterTaxGrowth AfterTaxGrowthNoTLH...
         PortfolioEndValue PortfolioEndValueNoTLH...
         EndCapitalGainsTax...
         HarvestedDates HarvestedAmounts]      = TLH(RetSeries,initialDeposit,initialWeights,...
                                                     [thresholds(i);thresholds(j)],taxRate,taxRateEnd);
                                                 
        AfterTaxGain(i,j) = AfterTaxGrowth;
        
        if AfterTaxGain(i,j) > currMaxAfterTaxGain
            currMaxAfterTaxGain = AfterTaxGain(i,j);
            currOptimalThreshold = [thresholds(i) thresholds(j)]';
        end
        
    end
end

[AfterTaxGrowth AfterTaxGrowthNoTLH...
 PortfolioEndValue PortfolioEndValueNoTLH...
 EndCapitalGainsTax...
 HarvestedDates HarvestedAmounts]      = TLH(RetSeries',initialDeposit,initialWeights,...
                                             currOptimalThreshold,taxRate,taxRateEnd);














