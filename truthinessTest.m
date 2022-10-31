function tests = truthinessTest()
    tests = functiontests(localfunctions());
end
%%
function testOperatorNot(testCase)
verifyFalse(testCase, ~truthy(true).logical);
verifyTrue(testCase, ~truthy(false).logical);
end
%%
function testOperatorCmp(testCase)
verifyTrue(testCase, truthy(true) == true);
verifyTrue(testCase, truthy(false) == false);
end
%%
function testOperationAnd(testCase)
verifyTrue(testCase, truthy(true).and(true).logical);
verifyFalse(testCase, truthy(true).and(false).logical);
verifyFalse(testCase, truthy(false).and(true).logical);
verifyFalse(testCase, truthy(false).and(false).logical);
end
%%
function testOperationOr(testCase)
verifyTrue(testCase, truthy(true).or(true).logical);
verifyTrue(testCase, truthy(true).or(false).logical);
verifyTrue(testCase, truthy(false).or(true).logical);
verifyFalse(testCase, truthy(false).or(false).logical);
end
%%
function testOperationXor(testCase)
verifyFalse(testCase, truthy(true).xor(true).logical);
verifyTrue(testCase, truthy(true).xor(false).logical);
verifyTrue(testCase, truthy(false).xor(true).logical);
verifyFalse(testCase, truthy(false).xor(false).logical);
end
%%
function testLazyEvaluation(testCase)

testCase.verifyTrue(truthy(true).orElse(@fail).logical);

function retval = fail()
    testCase.verifyFail('It SHOULD NEVER happen.');
    retval = false;  % NOTE: This line is never reached.
end

end
%%
function testHappeningOnlyOnce(testCase)

happenOnceOrFail = newHappening();
[~] = truthy(true) ...
    .andThen(@(~)happenOnceOrFail()) ...
    .orElse(@(~)happenOnceOrFail());

function func = newHappening
    hasHappened = [];
    func = @happenOnceOrFail;
    function retval = happenOnceOrFail()
        if isempty(hasHappened)
            hasHappened = true;
            retval = true;
            return
        elseif hasHappened
            testCase.verifyFail('It SHOULD NEVER happen.');
            retval = false;
            return
        end
    end
end

end
%%
function testFunctionWithNoReturns(testCase)

testCase.verifyError(@()truthy().andThen(@(~)returnNothing()), 'MATLAB:TooManyOutputs');
% NOTE: This behavior CAN be modified in the future.

function returnNothing, end

end
%%
function testFunctionWithNoParameters(testCase)

testCase.verifyError(@()truthy().andThen(@requireNothing), 'MATLAB:TooManyInputs');
% NOTE: This behavior CAN be modified in the future.

function retval = requireNothing
    retval = false;
end

end
