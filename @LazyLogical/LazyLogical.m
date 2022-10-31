classdef LazyLogical < Logicalness & handle
    % LazyLogical : Logical expression for unbound value
    %
    % See Also: TRUTHINESS and FALSINESS.

    properties(SetAccess = private)
        actualValue
    end
    properties(Access = private)
        boundValue
    end

    methods
        function obj = LazyLogical(val)
            obj.actualValue = val;
        end

        function retval = not(self)
            retval = ~(self.bind());
        end

        function retval = eq(self, other)
            retval = (isequal(self, other) ...
                || (string(class(self)) == class(other) && all(self.actualValue == other.actualValue)) ...
                || self.bind() == other);
        end

        function retval = and(self, other)
            retval = self.bind().and(other);
        end

        function retval = or(self, other)
            retval = self.bind().or(other);
        end

        function retval = xor(self, other)
            retval = self.bind().xor(other);
        end

        function retval = andThen(self, other)
            retval = self.bind().andThen(other);
        end

        function retval = orElse(self, other)
            retval = self.bind().orElse(other);
        end

        function retval = bind(self)
            if ~isempty(self.boundValue)
                retval = self.boundValue;
                return
            end
            if self.logical()
                retval = Truthiness.fromLazyLogical(self);
            else
                retval = Falsiness.fromLazyLogical(self);
            end
            self.boundValue = retval;
        end

        function retval = unwrap(self)
            retval = self.actualValue;
        end

        function retval = logical(self)
            retval = isTruthy(self.actualValue);
        end
    end
end
