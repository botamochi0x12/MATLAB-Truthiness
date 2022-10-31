
classdef Falsiness < Logicalness & handle
    % Falsiness : Logical expression for falsy value
    %
    % See Also: TRUTHINESS, LAZYLOGICAL.

    properties(SetAccess = private)
        actualValue
    end

    methods(Access = public, Static)
        function clsName = selfClassName()
            clsName = mfilename('class');
        end
        function inst = fromLazyLogical(val)
            validateattributes(val, {Falsiness.proxyClassName()}, {'scalar'});
            inst = Falsiness(val.actualValue);
        end
        function inst = DEFAULT()
            inst = Falsiness();
        end
    end

    methods(Access = private, Static)
        function clsName = proxyClassName()
            clsName = 'LazyLogical';
        end
    end

    methods(Access = private)
        function obj = Falsiness(val)
            if nargin == 0
                obj.actualValue = false;
                return
            end
            obj.actualValue = val;
            return
        end
    end

    methods
        function retval = not(self)
            retval = Truthiness.DEFAULT();
        end

        function retval = eq(self, other)
            retval = isequal(self, other) || self.logical() == other;
        end

        function retval = and(self, other)
            retval = self;
        end

        function retval = or(self, other)
            if ~self.isLogicalness(other)
                retval = self.or(LazyLogical(other));
                return
            end
            retval = other;
        end

        function retval = xor(self, other)
            if ~self.isLogicalness(other)
                retval = self.xor(LazyLogical(other));
                return
            end
            retval = other;
        end

        function retval = andThen(self, other)
            retval = self;
        end

        function retval = orElse(self, other)
            validateattributes(other, {'function_handle'}, {'scalar'});
            retval = LazyLogical(other(self.actualValue));
        end

        function retval = unwrap(self)
            retval = self.actualValue;
        end

        function retval = logical(self)
            retval = false;
        end

    end
end
