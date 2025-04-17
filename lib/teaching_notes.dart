import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class TeachingNotesScreen extends StatefulWidget {
  final String topic;

  TeachingNotesScreen({required this.topic});

  @override
  _TeachingNotesScreenState createState() => _TeachingNotesScreenState();
}

class _TeachingNotesScreenState extends State<TeachingNotesScreen> {
  int _currentPage = 0;

  final Map<String, List<String>> _teachingNotes = {
    '1.1 Numbers: HCF and LCM': [
    "Understanding Factors and Multiples\nA factor of a number divides it exactly without leaving a remainder.\nA multiple is the result of multiplying a number by an integer.\n\nExample:\nFactors of 12: 1, 2, 3, 4, 6, 12\nMultiples of 4: 4, 8, 12, 16, ...",
    "Finding HCF (Highest Common Factor)\nThe HCF of two numbers is the largest number that divides both of them exactly.\nMethod: List all the factors and find the highest common one.\nExample: Find the HCF of 12 and 18\nFactors of 12 = 1, 2, 3, 4, 6, 12\nFactors of 18 = 1, 2, 3, 6, 9, 18\nHCF = 6",
    "Finding LCM (Lowest Common Multiple)\nThe LCM is the smallest number that both original numbers divide into.\nMethod: List multiples of each number until you find a match.\nExample: Find the LCM of 4 and 5\nMultiples of 4: 4, 8, 12, 16, 20, ...\nMultiples of 5: 5, 10, 15, 20, ...\nLCM = 20",
    "Prime Factor Method for HCF and LCM\n1. Write both numbers as a product of primes\n2. For HCF: Take common primes with smallest powers\n3. For LCM: Take all primes with highest powers\n\nExample:\nFind HCF and LCM of 60 and 72\n60 = \$ 2^2 × 3 × 5 \$\n72 = \$ 2^3 × 3^2 \$\nHCF = \$ 2^2 × 3 = 12 \$\nLCM = \$ 2^3 × 3^2 × 5 = 360 \$",
    ],
    '1.2 Numbers: Powers': [
    "Understanding Powers\nA power (also called an exponent) shows how many times a number (base) is multiplied by itself.\nExample: \$ 3^4 = 3 × 3 × 3 × 3 = 81 \$",
    "Laws of Indices\n1. Multiplying powers with same base: \$ a^m × a^n = a^{m+n} \$\n2. Dividing powers with same base: \$ a^m ÷ a^n = a^{m-n} \$\n3. Power of a power: \$ (a^m)^n = a^{mn} \$\n4. Power of a product: \$ (ab)^n = a^n × b^n \$",
    "Negative and Fractional Powers\nNegative Power: \$ a^{-n} = \\frac{1}{a^n} \$\nFractional Power: \$ a^{\\frac{1}{n}} = \\sqrt[n]{a} \$\nExample:\n\$ 16^{-1/2} = \\frac{1}{\\sqrt{16}} = \\frac{1}{4} \$",
    "Zero Power Rule\nAny number (except 0) raised to the power of 0 is 1.\nExample: \$ 5^0 = 1 \$, \$ (-3)^0 = 1 \$",
    ],
    '1.3 Numbers: Fractions': [
    "What is a Fraction?\nA fraction represents a part of a whole.\nIt is written as:\n\$ \\frac{a}{b} \$ where:\n- a = numerator (top)\n- b = denominator (bottom)",
    "Simplifying Fractions\nDivide the numerator and denominator by their HCF.\nExample: \$ \\frac{12}{20} = \\frac{3}{5} \$",
    "Adding and Subtracting Fractions\n1. Find a common denominator\n2. Adjust numerators\n3. Add or subtract numerators\nExample: \$ \\frac{1}{4} + \\frac{1}{6} = \\frac{3}{12} + \\frac{2}{12} = \\frac{5}{12} \$",
    "Multiplying Fractions\nMultiply numerators and multiply denominators.\nExample: \$ \\frac{2}{3} × \\frac{4}{5} = \\frac{8}{15} \$",
    "Dividing Fractions\nFlip the second fraction and multiply.\nExample: \$ \\frac{2}{3} ÷ \\frac{4}{5} = \\frac{2}{3} × \\frac{5}{4} = \\frac{10}{12} = \\frac{5}{6} \$",
    "Mixed Numbers and Improper Fractions\nTo convert:\n- Mixed to improper: \$ 2\\frac{1}{3} = \\frac{7}{3} \$\n- Improper to mixed: \$ \\frac{9}{4} = 2\\frac{1}{4} \$",
    ],
    '1.4 Numbers: Ratios': [
      "Understanding Ratios\nA ratio compares two or more quantities.\nExample: If there are 2 apples and 3 oranges, the ratio is 2:3",
      "Simplifying Ratios\nDivide all parts by the same number.\nExample: 10:15 = 2:3 (divided by 5)",
      "Writing Ratios in Simplest Form\nUse the highest common factor to simplify.\nExample: 12:8 = 3:2",
      "Sharing in a Ratio\n1. Add parts of the ratio\n2. Divide total amount by total parts\n3. Multiply each part by this value\nExample: Share £60 in ratio 2:3\nTotal parts = 5\nEach part = £60 ÷ 5 = £12\nShares: 2 × £12 = £24 and 3 × £12 = £36",
      "Ratio and Fractions\nA ratio can be converted into a fraction of the total.\nExample: In ratio 3:1, the first part is \$ \\frac{3}{4} \$ and second part is \$ \\frac{1}{4} \$",
    ],
    '1.5 Numbers: Percentages': [
      "Understanding Percentages\n'Percent' means 'per hundred'.\nExample: 25% = \$ \\frac{25}{100} = 0.25 \$",
      "Converting Between Fractions, Decimals, and Percentages\nFraction to %: Multiply by 100\nDecimal to %: Multiply by 100\n% to Decimal: Divide by 100\nExample: \$ \\frac{3}{5} = 0.6 = 60% \$",
      "Finding a Percentage of an Amount\nUse multiplication:\nExample: 20% of 150 = \$ 0.20 × 150 = 30 \$",
      "Increasing and Decreasing by a Percentage\nIncrease: Multiply by \$ (1 + \\frac{percentage}{100}) \$\nDecrease: Multiply by \$ (1 - \\frac{percentage}{100}) \$\nExample: Increase £200 by 10%\nNew amount = \$ 200 × 1.10 = 220 \$",
      "Reverse Percentages\nUsed to find original amount before a % change.\nExample: Final price after 20% discount is £80\nLet original = x:\n\$ x × 0.8 = 80 \\Rightarrow x = \\frac{80}{0.8} = 100 \$",
    ],
    '2.1 Algebra: Equations and Formulae': [
      "Solving Linear Equations (One Step)\nA linear equation has the form \$ ax = b \$\nTo solve, divide both sides by 'a'.\nExample: Solve \$ 5x = 20 \$\n\$ x = \\frac{20}{5} = 4 \$",
      "Solving Linear Equations (Two Steps)\nRearrange to isolate the variable.\nExample: Solve \$ 2x + 3 = 11 \$\nSubtract 3: \$ 2x = 8 \$\nDivide by 2: \$ x = 4 \$",
      "Equations with Brackets\nExpand brackets first.\nExample: Solve \$ 3(x - 2) = 12 \$\nExpand: \$ 3x - 6 = 12 \$\nAdd 6: \$ 3x = 18 \$\nDivide: \$ x = 6 \$",
      "Equations with Variables on Both Sides\nMove all x terms to one side, constants to the other.\nExample: Solve \$ 4x + 3 = 2x + 11 \$\nSubtract 2x: \$ 2x + 3 = 11 \$\nSubtract 3: \$ 2x = 8 \$\nDivide: \$ x = 4 \$",
      "Equations Involving Fractions\nMultiply through by the denominator to eliminate fractions.\nExample: Solve \$ \\frac{x + 2}{3} = 5 \$\nMultiply by 3: \$ x + 2 = 15 \$\nSubtract 2: \$ x = 13 \$",
      "Rearranging Formulae\nChange the subject of a formula by isolating the variable.\nExample: Make \$ x \$ the subject of:\n\$ y = 3x + 7 \$\nSubtract 7: \$ y - 7 = 3x \$\nDivide: \$ x = \\frac{y - 7}{3} \$",
      "Rearranging with Brackets and Powers\nExpand and rearrange step by step.\nExample: Make \$ r \$ the subject: \$ A = \\pi r^2 \$\nDivide by \$ \\pi \$: \$ \\frac{A}{\\pi} = r^2 \$\nSquare root both sides: \$ r = \\sqrt{\\frac{A}{\\pi}} \$",
      "Forming Equations from Word Problems\nConvert real situations into algebra.\nExample: A number x is multiplied by 3 and increased by 4 to give 19.\nEquation: \$ 3x + 4 = 19 \$\nSolve: \$ x = 5 \$",
    ],
    '2.2 Algebra: Graphs': [
      "Linear Graphs (y = mx + c)\nThis is the equation of a straight line where:\n- m = gradient (steepness)\n- c = y-intercept (where the line crosses y-axis)\nExample: In \$ y = 2x + 1 \$, gradient = 2, y-intercept = 1",
      "Plotting Linear Graphs\n1. Create a table of x and y values\n2. Substitute x values into the equation to find y\n3. Plot the points and draw the line\nExample: For \$ y = x - 2 \$\nIf x = -1, 0, 1, then y = -3, -2, -1",
      "Finding the Gradient Between Two Points\nUse formula:\n\$ m = \\frac{y_2 - y_1}{x_2 - x_1} \$\nExample: Find gradient between A(1, 2) and B(4, 8)\n\$ m = \\frac{8 - 2}{4 - 1} = \\frac{6}{3} = 2 \$",
      "Parallel and Perpendicular Lines\n- Parallel lines have the same gradient\n- Perpendicular lines have gradients that multiply to -1\nExample: Line with gradient 2 ⟹ perpendicular line has gradient -\\frac{1}{2}",
      "Finding Equation from a Graph\nUse form \$ y = mx + c \$ and read values of m and c from the graph\nAlternatively, use two points to find m and substitute one point to find c",
      "Quadratic Graphs (y = ax^2 + bx + c)\n- U-shaped (positive a) or ∩-shaped (negative a)\n- Axis of symmetry at x = -\\frac{b}{2a}\n- Turning point = minimum or maximum point\nExample: For \$ y = x^2 + 4x + 3 \$\nAxis = -2, Turning point = (-2, -1)",
      "Cubic and Reciprocal Graphs\nCubic: S-shaped or reflected S, example: \$ y = x^3 - 2x \$\nReciprocal: Has asymptotes, example: \$ y = \\frac{1}{x} \$\nGraph never touches x or y axes",
      "Solving Graphically\nEquations like \$ y = x^2 + x - 6 \$ can be solved by finding where graph crosses x-axis\nSolutions are the x-intercepts",
    ],
    '2.3 Algebra: Simultaneous Equations': [
      "What Are Simultaneous Equations?\nTwo equations with two variables, solved together to find the same values for x and y.\nExample:\n\$ x + y = 10 \$\n\$ x - y = 2 \$",
      "Solving by Substitution\n1. Rearrange one equation to make x or y the subject\n2. Substitute into the other equation\n3. Solve for one variable, then back-substitute\nExample:\n\$ y = 10 - x \$\nSub into 2nd: \$ x - (10 - x) = 2 \$\nSolve: \$ 2x = 12 ⟹ x = 6, y = 4 \$",
      "Solving by Elimination\n1. Make the coefficients of one variable the same\n2. Add or subtract the equations to eliminate a variable\n3. Solve the resulting equation\nExample:\n\$ 2x + y = 7 \$\n\$ 3x + y = 9 \$\nSubtract: \$ -x = -2 ⟹ x = 2, y = 3 \$",
      "Equations with Multiplication Needed\nIf coefficients don't match, multiply both equations to align variables\nExample:\n\$ 2x + 3y = 12 \$\n\$ 3x + 2y = 11 \$\nMultiply 1st by 3: \$ 6x + 9y = 36 \$\nMultiply 2nd by 2: \$ 6x + 4y = 22 \$\nSubtract to eliminate x",
      "Solving Graphically\nPlot both equations on the same graph\nThe point of intersection is the solution\nThis method works for linear-linear and linear-quadratic equations",
      "Simultaneous Equation with Quadratic\nSolve linear and quadratic together\nExample:\n\$ y = 2x + 1 \$ (linear)\n\$ y = x^2 + x + 1 \$ (quadratic)\nSet equal: \$ 2x + 1 = x^2 + x + 1 ⟹ x^2 - x = 0 ⟹ x(x - 1) = 0 \$\nSo x = 0 or x = 1, then find y",
    ],
    '2.4 Algebra: Polynomials': [
      "Understanding Polynomials\nA polynomial is an algebraic expression that consists of variables, coefficients, and exponents combined using addition, subtraction, and multiplication. The general form of a polynomial is:\n\$ a_nx^n + a_{n-1}x^{n-1} + ... + a_1x + a_0 \$\nwhere \$ a_n, a_{n-1}, ..., a_0 \$ are coefficients and \$ n \$ is the highest exponent.\n\nExample: \$ 3x^4 - 2x^3 + 5x^2 - x + 7 \$",
      "Adding and Subtracting Polynomials\nTo add or subtract polynomials, combine like terms.\nExample: \n\$ (3x^2 + 5x - 7) + (2x^2 - 3x + 4) \$\n\$ = (3x^2 + 2x^2) + (5x - 3x) + (-7 + 4) \$\n\$ = 5x^2 + 2x - 3 \$",
      "Multiplying Polynomials\nTo multiply polynomials, use the distributive property.\nExample: Multiply \$ (x + 2)(x - 3) \$\n\$ x(x - 3) + 2(x - 3) \$\n\$ = x^2 - 3x + 2x - 6 \$\n\$ = x^2 - x - 6 \$",
      "Expanding Triple Brackets\nMultiply two brackets first, then multiply the result by the third bracket.\nExample: Expand \$ (x + 1)(x + 2)(x + 3) \$\nFirst, expand \$ (x + 1)(x + 2) \$:\n\$ x^2 + 2x + x + 2 = x^2 + 3x + 2 \$\nNow multiply by \$ (x + 3) \$:\n\$ (x^2 + 3x + 2)(x + 3) \$\n\$ x^3 + 3x^2 + 2x + 3x^2 + 9x + 6 \$\n\$ = x^3 + 6x^2 + 11x + 6 \$",
      "Dividing Polynomials (Long Division)\nPolynomial division is similar to numerical long division.\nExample: Divide \$ (x^3 - 3x^2 + x - 5) \$ by \$ (x - 2) \$\n1. Divide \$ x^3 \$ by \$ x \$: \$ x^2 \$\n2. Multiply: \$ x^2(x - 2) = x^3 - 2x^2 \$\n3. Subtract: \$ (x^3 - 3x^2 + x - 5) - (x^3 - 2x^2) = -x^2 + x - 5 \$\n4. Divide \$ -x^2 \$ by \$ x \$: \$ -x \$\n5. Multiply: \$ -x(x - 2) = -x^2 + 2x \$\n6. Subtract: \$ (-x^2 + x - 5) - (-x^2 + 2x) = -x - 5 \$\n7. Divide \$ -x \$ by \$ x \$: \$ -1 \$\n8. Multiply: \$ -1(x - 2) = -x + 2 \$\n9. Subtract: \$ (-x - 5) - (-x + 2) = -7 \$\n\nSo the quotient is \$ x^2 - x - 1 \$ with remainder \$ -7 \$.",
      "Factorising Cubic Polynomials\nStep 1: Find a common factor or use the factor theorem.\nStep 2: Perform polynomial division if necessary.\nExample: Factorise \$ x^3 - 6x^2 + 11x - 6 \$\nTry \$ x = 1 \$:\n\$ 1^3 - 6(1)^2 + 11(1) - 6 = 0 \$\nSo \$ (x - 1) \$ is a factor.\nPerform polynomial division:\n\$ (x^3 - 6x^2 + 11x - 6) \div (x - 1) = x^2 - 5x + 6 \$\nFactorise \$ x^2 - 5x + 6 = (x - 2)(x - 3) \$\nFinal factorisation:\n\$ (x - 1)(x - 2)(x - 3) \$\n",
      "Using the Remainder Theorem\nIf \$ f(x) \$ is divided by \$ (x - a) \$, the remainder is \$ f(a) \$.\nExample: Find the remainder when \$ f(x) = x^3 - 4x + 5 \$ is divided by \$ (x - 2) \$\nSubstituting \$ x = 2 \$:\n\$ f(2) = 2^3 - 4(2) + 5 \$\n\$ = 8 - 8 + 5 = 5 \$\nSo the remainder is 5.\n",
      "Using the Factor Theorem\nIf \$ f(a) = 0 \$, then \$ (x - a) \$ is a factor.\nExample: Show that \$ x - 2 \$ is a factor of \$ x^3 - 3x^2 - 4x + 8 \$\nSubstituting \$ x = 2 \$:\n\$ 2^3 - 3(2)^2 - 4(2) + 8 \$\n\$ = 8 - 12 - 8 + 8 = 0 \$\nSince \$ f(2) = 0 \$, \$ (x - 2) \$ is a factor.\n",
      "Solving Polynomial Equations\nFactorise or use polynomial division to find solutions.\nExample: Solve \$ x^3 - 3x^2 - 4x + 8 = 0 \$\nSince \$ (x - 2) \$ is a factor, divide by \$ (x - 2) \$:\n\$ (x^3 - 3x^2 - 4x + 8) \div (x - 2) = x^2 - x - 4 \$\nSolve \$ x^2 - x - 4 = 0 \$ using the quadratic formula:\n\$ x = \frac{-(-1) \pm \sqrt{(-1)^2 - 4(1)(-4)}}{2(1)} \$\n\$ x = \frac{1 \pm \sqrt{1 + 16}}{2} \$\n\$ x = \frac{1 \pm \sqrt{17}}{2} \$\nSo solutions are \$ x = 2, \frac{1 \pm \sqrt{17}}{2} \$.\n",
    ],
    '3.1 Geometry: Angles': [
      "Types of Angles\n- Acute: Less than 90°\n- Right Angle: Exactly 90°\n- Obtuse: Between 90° and 180°\n- Straight Line: 180°\n- Reflex: Greater than 180°",
      "Angles on a Straight Line\nAngles on a straight line add up to 180°.\nExample: If one angle is 120°, the other is:\n\$ 180° - 120° = 60° \$",
      "Angles Around a Point\nAngles around a point add up to 360°.\nExample: If three angles are 100°, 110°, and 80°:\nRemaining angle = \$ 360° - (100° + 110° + 80°) = 70° \$",
      "Vertically Opposite Angles\nWhen two lines cross, opposite angles are equal.\nExample: If one angle is 65°, the angle opposite is also 65°",
      "Angles in a Triangle\nAngles in a triangle always add up to 180°.\nExample: If two angles are 50° and 60°:\nThird angle = \$ 180° - (50° + 60°) = 70° \$",
      "Angles in Quadrilaterals\nAngles in any quadrilateral add up to 360°.\nExample: If three angles are 90°, 80°, and 100°:\nFourth = \$ 360° - 270° = 90° \$",
      "Angles in Parallel Lines\n- Alternate angles: Equal ('Z' shape)\n- Corresponding angles: Equal ('F' shape)\n- Co-interior angles: Add to 180° ('C' shape)",
      "Exterior and Interior Angles of Polygons\nExterior angles of a regular polygon add up to 360°\nEach exterior angle = \$ \\frac{360°}{n} \$ where n is the number of sides\nInterior angle = \$ 180° - \\text{Exterior angle} \$",
    ],
    '3.2 Geometry: Pythagoras Theorem': [
      "Pythagoras Theorem\nUsed in right-angled triangles only.\nFormula: \$ a^2 + b^2 = c^2 \$ where c = hypotenuse (longest side)\nExample: Find c if a = 3, b = 4:\n\$ c^2 = 3^2 + 4^2 = 9 + 16 = 25 ⟹ c = 5 \$",
      "Finding a Shorter Side\nRearrange to find a or b:\nFormula: \$ a^2 = c^2 - b^2 \$\nExample: c = 10, b = 6\n\$ a^2 = 10^2 - 6^2 = 100 - 36 = 64 ⟹ a = 8 \$",
      "Pythagoras in Word Problems\nUse when finding distances (e.g., diagonals, ladders, slanted lines)\nExample: Diagonal of rectangle with width = 5m, height = 12m:\n\$ d^2 = 5^2 + 12^2 = 25 + 144 = 169 ⟹ d = 13m \$",
      "Checking for a Right-Angled Triangle\nCheck if \$ a^2 + b^2 = c^2 \$\nExample: Sides 5, 12, 13:\n\$ 5^2 + 12^2 = 25 + 144 = 169 = 13^2 ⟹ Yes, right-angled \$",
    ],
    '3.3 Geometry: Trigonometry': [
      "Introduction to Trigonometry\nUsed in right-angled triangles to find unknown sides or angles.\nKey ratios:\n- sin(θ) = opposite ÷ hypotenuse\n- cos(θ) = adjacent ÷ hypotenuse\n- tan(θ) = opposite ÷ adjacent",
      "Using Trigonometry to Find a Side\nRearrange the formula to solve for missing side.\nExample: Find x if:\n\$ \\sin(30°) = \\frac{x}{10} \$\nMultiply: \$ x = 10 × \\sin(30°) = 5 \$",
      "Using Trigonometry to Find an Angle\nUse inverse functions (sin⁻¹, cos⁻¹, tan⁻¹).\nExample: \$ \\cos(θ) = \\frac{4}{5} \$\n\$ θ = \\cos^{-1}(\\frac{4}{5}) ≈ 36.87° \$",
      "Labeling Sides in Triangles\n- Hypotenuse: opposite the right angle\n- Opposite: opposite the angle in question\n- Adjacent: next to the angle and right angle",
      "Using the Correct Formula\nUse SOHCAHTOA depending on which sides are known and which is missing.\n- Use sin if you know opposite and hypotenuse\n- Use cos for adjacent and hypotenuse\n- Use tan for opposite and adjacent",
      "Trigonometric Word Problems\nUsed in ladders, inclines, angles of elevation/depression, etc.\nExample: A ramp is 5m long and rises at 20°\nHeight = \$ 5 × \\sin(20°) ≈ 1.71m \$",
    ],
    '3.4 Geometry: Perimeter and Area': [
      "Perimeter\nPerimeter is the total distance around the edge of a shape.\nExample: Perimeter of rectangle = \$ 2(l + w) \$\nIf l = 5, w = 3: Perimeter = \$ 2(5 + 3) = 16 \$",
      "Area of Rectangle and Triangle\n- Rectangle: \$ \\text{Area} = l × w \$\n- Triangle: \$ \\text{Area} = \\frac{1}{2} × b × h \$",
      "Area of Parallelogram and Trapezium\n- Parallelogram: \$ b × h \$\n- Trapezium: \$ \\frac{1}{2}(a + b)h \$ where a and b are parallel sides",
      "Area and Circumference of a Circle\n- Area: \$ \\pi r^2 \$\n- Circumference: \$ 2\\pi r \$ or \$ \\pi d \$\nExample: If r = 7:\nArea = \$ \\pi × 49 ≈ 153.94 \$\nCircumference = \$ 2\\pi × 7 ≈ 43.98 \$",
      "Area of Compound Shapes\nBreak into basic shapes (rectangle, triangle, semicircle, etc.)\nAdd or subtract areas accordingly",
      "Working with Units\nMake sure all lengths are in same units.\n- Area: always in squared units (e.g., cm²)\n- Perimeter: linear units (e.g., cm, m)",
    ],
    '4.1 Statistics: Probability': [
      "Basic Probability\nProbability = chance of an event happening\nFormula: \$ \\text{Probability} = \\frac{\\text{favourable outcomes}}{\\text{total outcomes}} \$\nExample: Roll a die, get a 4:\n\$ \\frac{1}{6} \$",
      "Probability Scale\nProbability is between 0 and 1\n- 0 = impossible\n- 1 = certain\n- 0.5 = even chance",
      "Listing Outcomes\nUse sample space diagrams or lists to show all possible outcomes.\nExample: Flip a coin and roll a die:\nOutcomes: H1, H2, H3, H4, H5, H6, T1, T2, ..., T6",
      "Mutually Exclusive Events\nTwo events cannot happen at the same time.\n\$ P(A \\,\\text{or}\\, B) = P(A) + P(B) \$\nExample: Red or Blue from bag:\n\$ \\frac{3}{10} + \\frac{2}{10} = \\frac{5}{10} \$",
      "Probability from Tables and Frequency Trees\nUse total values to work out unknown probabilities.\nAlways check totals add up correctly.",
      "Relative Frequency\nUsed when probabilities are based on experiments:\n\$ \\text{Relative Frequency} = \\frac{\\text{Number of times event occurs}}{\\text{Total trials}} \$",
      "Complement Rule\n\$ P(\\text{Not A}) = 1 - P(A) \$\nUseful when it’s easier to find what you don’t want!",
    ],
    '4.2 Statistics: Histograms': [
      "Understanding Histograms\nHistograms are used to show frequency of grouped data.\nThe area of each bar represents frequency, not the height.",
      "Drawing Histograms\n1. Use class widths on x-axis\n2. Calculate frequency density:\n\$ \\text{Frequency density} = \\frac{\\text{frequency}}{\\text{class width}} \$\n3. Plot bars with height = frequency density",
      "Example:\nClass 10–20 with frequency 12\nWidth = 10\nFrequency density = \$ \\frac{12}{10} = 1.2 \$",
      "Interpreting Histograms\n- Taller bars = higher frequency density\n- Wider bars = larger range of values\n- Estimate frequency by multiplying:\n\$ \\text{Frequency} = \\text{FD} × \\text{width} \$",
      "Finding Total Frequency\nAdd up all estimated frequencies (FD × width for each bar)",
      "When to Use a Histogram\nUse when data is continuous and grouped into intervals (e.g. height, time)",
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<String> notes = _teachingNotes[widget.topic] ?? ["No notes available for this topic."];

    return Scaffold(
      appBar: AppBar(title: Text("Learn: ${widget.topic}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _parseMathAndText(notes[_currentPage]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 0 ? () {
                    setState(() {
                      _currentPage--;
                    });
                  } : null,
                  child: Text("Previous"),
                ),
                Text("Page ${_currentPage + 1} of ${notes.length}", style: TextStyle(fontSize: 16)),
                ElevatedButton(
                  onPressed: _currentPage < notes.length - 1 ? () {
                    setState(() {
                      _currentPage++;
                    });
                  } : null,
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  List<Widget> _parseMathAndText(String text, {double fontSize = 18}) {
    List<Widget> widgets = [];
    RegExp mathPattern = RegExp(r"\$(.*?)\$");

    Iterable<Match> matches = mathPattern.allMatches(text);
    int lastMatchEnd = 0;

    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        widgets.add(
          Text(
            text.substring(lastMatchEnd, match.start),
            style: TextStyle(fontSize: fontSize),
            softWrap: true,
          ),
        );
      }

      widgets.add(
        Math.tex(
          match.group(1)!,
          textStyle: TextStyle(fontSize: fontSize + 4, fontWeight: FontWeight.bold),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      widgets.add(
        Text(
          text.substring(lastMatchEnd),
          style: TextStyle(fontSize: fontSize),
          softWrap: true,
        ),
      );
    }

    return widgets;
  }
}