function samples = Fun_splitVectorIntoSamples(vector, sampleSize)
    numSamples = length(vector) / sampleSize;
    samples = reshape(vector, sampleSize, numSamples)';
end
