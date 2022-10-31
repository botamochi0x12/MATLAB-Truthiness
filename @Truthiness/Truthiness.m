
classdef Truthiness < Logicalness & handle
    % Truthiness : Logical expression for truthy value
    %
    % See Also: FALSINESS, LAZYLOGICAL.

    properties(SetAccess = private)
        actualValue
    end

    methods(Access = public, Static)
        function clsName = selfClassName()
            clsName = mfilename('class');
        end
        function inst = fromLazyLogical(val)
            validateattributes(val, {Truthiness.proxyClassName()}, {'scalar'});
            inst = Truthiness(val.actualValue);
        end
        function inst = DEFAULT()
            inst = Truthiness();
        end
    end

    methods(Access = private, Static)
        function clsName = proxyClassName()
            clsName = 'LazyLogical';
        end
    end

    methods(Access = private)
        function obj = Truthiness(val)
            if nargin == 0
                obj.actualValue = true;
                return
            end
            obj.actualValue = val;
            return
        end
    end

    methods
        function retval = not(self)
            retval = Falsiness.DEFAULT();
        end

        function retval = eq(self, other)
            retval = isequal(self, other) || self.logical() == other;
        end

        function retval = and(self, other)
            if ~self.isLogicalness(other)
                retval = self.and(LazyLogical(other));
                return
            end
            retval = other;
        end

        function retval = or(self, other)
            retval = self;
        end

        function retval = xor(self, other)
            if ~self.isLogicalness(other)
                retval = self.xor(LazyLogical(other));
                return
            end
            retval = ~other;
        end

        function retval = andThen(self, other)
            validateattributes(other, {'function_handle'}, {'scalar'});
            retval = LazyLogical(other(self.actualValue));
        end

        function retval = orElse(self, other)
            retval = self;
        end

        function retval = unwrap(self)
            retval = self.actualValue;
        end

        function retval = logical(self)
            retval = true;
        end

    end
end
