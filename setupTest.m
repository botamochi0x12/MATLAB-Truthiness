function tests = shorthandsTest()
    addpath('shorthands');
    tests = functiontests(localfunctions());
end

function testCallTr(testCase)
    try
        tr(true);
    catch
        testCase.verifyFail('It SHOULD NEVER happen.');
    end
end
