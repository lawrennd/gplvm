function g = pointNegGradX(x, y, model, prior)

% POINTNEGGRADX Wrapper function for calling noise gradients.

% GPLVM

g = - ivmGradX(model, x, y);

if prior
  g =g +x;
end