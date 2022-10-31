function out = resolveTruthinessChain(varargin)
% Evaluate parameters as a truthy value if exec. of arguments else false
%
%
% | op  | prev | curr |  out  |
% | --- | ---- | ---- | ----- |
% | and |  T1  |  T2  |  T2   |
% | and |  T1  |  F2  | false |
% | and |  F1  |  T2  | false |
% | and |  F1  |  F2  | false |
% | or  |  T1  |  T2  |  T1   |
% | or  |  T1  |  F2  |  T1   |
% | or  |  F1  |  T2  |  T2   |
% | or  |  F1  |  F2  | false |
%

    % check if even
    if mod(nargin, 2) == 0
        error( ...
            "ArgumentError" ...
            + "The number of input arguments must be odd.");
    end

    if nargin == 1
        out = varargin{1};
        return
    end

    % NOTE: (`prev` `op` `curr`)
    % FIXME: priority of operaters
    prev = varargin{1};
    for i = 3:2:nargin
        op = varargin{i - 1};
        curr = varargin{i};

        if isequal(op, @and)
            if isTruthy(prev) && isTruthy(curr)
                prev = curr;
            else
                prev = false;
            end
        elseif isequal(op, @or)
            if isTruthy(prev)
                continue
            elseif isTruthy(curr)
                prev = curr;
            else
                prev = false;
            end
        else
            error( ...
                "UnsupportedOperatorError" ...
                + "%s is not spported. Use `add` or `or`." ...
            );
        end
    end

    out = prev;
end
%%
