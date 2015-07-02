var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');

var pi = Math.PI,   e = Math.E,       i = math.complex('i'),
    sin = math.sin, cos = math.cos,   pow = math.pow,
    add = math.add, sqrt = math.sqrt, mul = math.multiply,
    abs = math.abs, div = math.divide,  ln = math.log,
    im = math.im, re = math.re, atg = math.atanh,
    no = function(a) { return math.complex(-a.re, -a.im) },
    sub = function(a, b) { return add(a, no(b)) };

var h = 600, w = 600, r = 200;
var phi_0 = -pi / 4, theta_0 = pi / 3;

ctx.canvas.height = h;
ctx.canvas.width = w;

ctx.fillStyle = '#bacbac';
ctx.fillRect(0, 0, w, h);

Vector = (function() {
  function Vector(x, y, z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Vector.prototype.add = function(vector) {
    this.x += vector.x;
    this.y += vector.y;
    this.z += vector.z;
    return this;
  }

  Vector.prototype.scal = function(vector) {
    return this.x * vector.x + this.y * vector.y + this.z * vector.z;
  }

  return Vector;
})();

// calculating x & y in 2d canvas
calc = function(vector) {
  // координаты ортов в плоскости экрана в декартовых координатах
  ex = new Vector(1, pi / 2, phi_0 + pi / 2 );
  ey = new Vector(1, theta_0 - pi / 2, phi_0);

  dx = ex.scal(vector) / sqrt(3.5);
  dy = ey.scal(vector) / sqrt(3.5);
  delete ex;
  delete ey;

  return {'x': -dx, 'y': -dy};
}

angleToCoords = function(phi, theta) {
  var x = sin(theta) * cos(phi);
  var y = sin(theta) * sin(phi);
  var z = cos(theta);
  return new Vector(x, y, z);  
}

angleToComponents = function(phi, theta) {
  var alpha = 0, beta = 0;
  alpha = math.complex(cos(theta / 2), 0);
  beta = mul(pow(e, mul(i, phi)), sin(theta / 2));
  return {'alpha': alpha, 'beta': beta}
}

componentsToAngle = function(alpha, beta) {
  var phi, theta;
  phi = re(mul(no(i), ln(div(beta, sqrt(sub(1, pow(alpha, 2)))))));
  theta = re(mul(4, atg(div(sub(1, alpha), add(1, alpha)))));
  return {'phi': phi, 'theta': theta};
}

gate = function(qubit, type) {
  var alpha = qubit.alpha;
  var beta = qubit.beta;
  switch (type) {
    case 'X':
      qubit.alpha = beta;
      qubit.beta = alpha;
      break;
    case 'Y':
      qubit.alpha = mul(i, no(beta));
      qubit.beta = mul(i, alpha);
      break;
    case 'Z':
      qubit.beta = no(beta);
      break;
    case 'H':
      qubit.alpha = mul(1 / sqrt(2), add(alpha, beta));
      qubit.beta = mul(1 / sqrt(2), sub(alpha, beta));
      break;
    case 'T':
      qubit.beta = mul(beta, pow(e, mul(i, pi / 8)));
      break;
    case 'S':
      qubit.beta = mul(beta, i);
      break;
  }
  alpha = qubit.alpha, beta = qubit.beta;
  var angle = componentsToAngle(alpha, beta);
  qubit.phi = angle.phi, qubit.theta = angle.theta;
  redraw();
}

Qubit = (function() {
  // init function
  function Qubit(phi, theta) {
    this.phi = phi;
    this.theta = theta;
    var comps = angleToComponents(phi, theta);
    this.alpha = comps.alpha;
    this.beta = comps.beta;
  }
  
  // rotating by theta & phi angles
  Qubit.prototype.rotate = function(phi, theta) {
    this.phi -= phi;
    this.theta -= theta;
    if (this.phi < 2 * pi) this.phi += 2 * pi;
    if (this.theta < 2 * pi) this.theta += 2 * pi;
    return this;
  };
  
  // draw qubit on 2d canvas
  Qubit.prototype.draw = function() {
    var theta = this.theta;
    var phi = this.phi;
    var vector = angleToCoords(phi, theta);

    var dx = calc(vector).x;
    var dy = calc(vector).y;
    // drawing line
    ctx.beginPath();
    ctx.moveTo(w / 2, h / 2);
    ctx.lineTo(w / 2 + r * dx,
      h / 2 - r * dy);
    ctx.closePath();
    ctx.strokeStyle = ctx.fillStyle = '#7733ff';
    ctx.stroke();
    // drawing arrow
    x = w / 2 + r * dx;
    y = h / 2 - r * dy;
    a = dx * dx + dy * dy;
    dx /= sqrt(a);
    dy /= sqrt(a);
    ctx.beginPath();
    ctx.moveTo(x, y);
    ctx.lineTo(x - 10 * dx - 5 * dy, y + 10 * dy - 5 * dx);
    ctx.lineTo(x - 10 * dx + 5 * dy, y + 10 * dy + 5 * dx);
    ctx.closePath();
    ctx.fill();
    delete vector;
  }
  
  return Qubit;
})();

Background = (function() {
  function Background() {
    this.color = '#f7f7f7';
  }
  
  // drawing x, y & z axes on canvas
  Background.prototype.drawAxes = function() {
    ctx.strokeStyle = ctx.fillStyle = '#000000';
    // x axis
    ctx.beginPath();
      ctx.moveTo(w / 10, h / 2);
      ctx.lineTo(w / 2 - r, h / 2);
      ctx.save();
    ctx.stroke();
    ctx.beginPath();
      ctx.setLineDash([5]);
      ctx.moveTo(w / 2 - r, h / 2);
      ctx.lineTo(w / 2 + r, h / 2);
    ctx.stroke();
    ctx.beginPath();
      ctx.restore();
      ctx.moveTo(w / 2 + r, h / 2);
      ctx.lineTo(w * 9 / 10, h / 2);
    ctx.stroke();
    ctx.beginPath();
      ctx.moveTo(w * 9 / 10, h / 2);
      ctx.lineTo(w * 9 / 10 - 10, h / 2 - 5);
      ctx.lineTo(w * 9 / 10 - 10, h / 2 + 5);
    ctx.closePath();
    ctx.fill();
    
    // y axis
    ctx.beginPath();
      ctx.moveTo(w / 2, h * 9 / 10);
      ctx.lineTo(w / 2, h / 2 + r);
      ctx.save();
    ctx.stroke();    
    ctx.beginPath();
      ctx.setLineDash([5]);
      ctx.moveTo(w / 2, h / 2 + r);
      ctx.lineTo(w / 2, h / 2 - r);
    ctx.stroke();    
    ctx.beginPath();
      ctx.restore();
      ctx.moveTo(w / 2, h / 2 - r);
      ctx.lineTo(w / 2, h / 10);
    ctx.stroke();
    ctx.beginPath();
      ctx.moveTo(w / 2, h / 10);
      ctx.lineTo(w / 2 - 5, h / 10 + 10);
      ctx.lineTo(w / 2 + 5, h / 10 + 10);
    ctx.closePath();
    ctx.fill();
    
    // z axis
    ctx.beginPath();
      ctx.moveTo(w / 2 + w / 3, h / 2 - h / 3);
      ctx.lineTo(w / 2 + w / 6.7, h / 2 - h / 6.7);
      ctx.save();
    ctx.stroke();
    ctx.beginPath();
      ctx.setLineDash([5]);
      ctx.moveTo(w / 2 + w / 6.7, h / 2 - h / 6.7);
      ctx.lineTo(w / 2 - w / 6.7, h / 2 + h / 6.7);
    ctx.stroke();
    ctx.beginPath();
      ctx.restore();
      ctx.moveTo(w / 2 - w / 6.7, h / 2 + h / 6.7);
      ctx.lineTo(w / 2 - w / 3, h / 2 + h / 3);
    ctx.stroke();
    ctx.beginPath();
      ctx.moveTo(w / 2 - w / 3, h / 2 + h / 3);
      ctx.lineTo(w / 2 - w / 3 + 5 / Math.sqrt(2),
        h / 2 + h / 3 - 15 / Math.sqrt(2));
      ctx.lineTo(w / 2 - w / 3 + 15 / Math.sqrt(2),
        h / 2 + h / 3 - 5 / Math.sqrt(2));
    ctx.closePath();
    ctx.fill();
  }
  
  //drawing sphere on canvas
  Background.prototype.drawSphere = function() {
    ctx.strokeStyle = ctx.fillStyle = '#000000';
    ctx.save();
    ctx.beginPath();
      // whole sphere
      ctx.arc(w / 2, h / 2, r, 0, Math.PI * 2, true);
      // front half-ring
      ctx.moveTo(w / 2 - r, h / 2);
      ctx.bezierCurveTo(w / 2 - r * 0.9, h / 2 + h / 4.5,
        w / 2 + r * 0.9, h / 2 + h / 4.5, w / 2 + r, h / 2);
    ctx.stroke();
    
    ctx.beginPath();
      // back half-ring
      ctx.moveTo(w / 2 - r, h / 2);
      ctx.setLineDash([5]);
      ctx.bezierCurveTo(w / 2 - r * 0.9, h / 2 - h / 4.5,
        w / 2 + r * 0.9, h / 2 - h / 4.5, w / 2 + r, h / 2);
    ctx.stroke();
    ctx.restore();
  }
  
  // clear canvas
  Background.prototype.clear = function() {
    ctx.fillStyle = this.color;
    ctx.fillRect(0, 0, w, h);
    ctx.fill();
  }
  
  return Background;
})();

var bg = new Background();
var Phi = pi / math.floor(math.random(10));   // start angle phi
var Theta = pi / math.floor(math.random(10)); // start angle theta
q = new Qubit(Phi, Theta);

function redraw() {
  // drawing
  bg.clear();
  bg.drawAxes();
  bg.drawSphere();
  q.draw();
  
  var labelAlpha = document.getElementById('alpha');
  var labelBeta = document.getElementById('beta');

  var are = q.alpha.re.toFixed(2);
  var aim = q.alpha.im;
  var bre = q.beta.re.toFixed(2);
  var bim = q.beta.im;
  labelAlpha.innerHTML = '&#x03b1; = ' + are +
    ((aim < 0) ? ' - ' : ' + ') + abs(aim).toFixed(2) + 'i';
  labelBeta.innerHTML = '&#x03b2; = ' + bre +
    ((bim < 0) ? ' - ' : ' + ') + abs(bim).toFixed(2) + 'i';
}

redraw();
