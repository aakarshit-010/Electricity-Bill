<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = (String) request.getAttribute("message");
    Object totalObj = request.getAttribute("total");
    Double total = totalObj instanceof Double ? (Double) totalObj : null;
    Integer units = (Integer) request.getAttribute("units");
    Double slab1 = (Double) request.getAttribute("slab1");
    Double slab2 = (Double) request.getAttribute("slab2");
    Double slab3 = (Double) request.getAttribute("slab3");
    Double slab4 = (Double) request.getAttribute("slab4");
    java.text.DecimalFormat priceFormat = (java.text.DecimalFormat) request.getAttribute("priceFormat");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Bill Calculator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(circle at top left, #28a745 0%, transparent 35%),
                        radial-gradient(circle at bottom right, #6610f2 0%, transparent 32%),
                        linear-gradient(135deg, #020024 0%, #0d1b2a 46%, #12244b 100%);
            color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .hero {
            padding: 4rem 0 2rem;
        }

        .hero-card {
            backdrop-filter: blur(18px);
            background: rgba(255, 255, 255, 0.10);
            border: 1px solid rgba(255, 255, 255, 0.18);
            box-shadow: 0 24px 80px rgba(0, 0, 0, 0.42);
        }

        .feature-chip {
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.14);
            padding: 0.55rem 1rem;
            margin-right: 0.5rem;
            color: #e9ecef;
            font-size: 0.9rem;
        }

        .btn-glow {
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn-glow::before {
            content: '';
            position: absolute;
            width: 120%;
            height: 120%;
            background: radial-gradient(circle, rgba(255,255,255,0.35), transparent 45%);
            top: -50%;
            left: -40%;
            opacity: 0;
            transform: scale(0.3);
            transition: opacity 0.35s ease, transform 0.35s ease;
        }

        .btn-glow:hover::before {
            opacity: 1;
            transform: scale(0.9);
        }

        .result-panel {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.16);
            box-shadow: 0 18px 50px rgba(0, 0, 0, 0.22);
        }

        .bill-item {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }

        .bill-item:last-child {
            border-bottom: none;
        }

        .animated-text {
            opacity: 0;
            transform: translateY(15px);
            animation: fadeUp 0.9s ease forwards;
            animation-delay: 0.35s;
        }

        @keyframes fadeUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .badge-slabs {
            font-size: 0.82rem;
            letter-spacing: 0.04em;
        }

        @media (max-width: 767px) {
            .hero {
                padding: 3rem 0 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center align-items-center hero">
        <div class="col-xl-8 col-lg-10">
            <div class="card hero-card p-4 p-lg-5 rounded-4 animated-text">
                <div class="row g-4 align-items-center">
                    <div class="col-lg-6">
                        <div class="text-white mb-4">
                            <h1 class="display-6 fw-bold">Electricity Bill Calculator</h1>
                            <p class="lead text-muted">Enter your monthly consumption and get a detailed bill with smart slab pricing.</p>
                        </div>
                        <div class="mb-3 d-flex flex-wrap gap-2">
                            <span class="feature-chip">First 50 units @ ₹3.50</span>
                            <span class="feature-chip">Next 100 units @ ₹4.00</span>
                            <span class="feature-chip">Next 100 units @ ₹5.20</span>
                            <span class="feature-chip">Above 250 units @ ₹6.50</span>
                        </div>
                        <div class="text-white-50">
                            <p>Designed for a premium responsive experience with animated feedback and modern color styling.</p>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card result-panel p-4 rounded-4">
                            <h5 class="mb-3 text-white">Calculate Your Bill</h5>
                            <form action="calculate" method="post" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label for="units" class="form-label text-white">Total units consumed</label>
                                    <input type="number" min="0" class="form-control form-control-lg bg-dark text-white border-white-25" id="units" name="units" placeholder="e.g. 180" required>
                                    <div class="invalid-feedback">Enter a non-negative number of units.</div>
                                </div>
                                <button type="submit" class="btn btn-success btn-lg w-100 btn-glow">Compute Bill</button>
                            </form>
                            <% if (message != null) { %>
                                <div id="resultArea" class="mt-4">
                                    <div class="alert <%= (total != null && total >= 0) ? "alert-success" : "alert-danger" %> bg-opacity-10 text-white border-0" role="alert">
                                        <%= message %>
                                    </div>
                                    <% if (total != null && total >= 0) { %>
                                        <div class="card bg-black bg-opacity-10 border-white-10 rounded-4 p-3 mt-2">
                                            <div class="mb-3 text-white-50">Bill summary for <strong><%= units != null ? units : 0 %></strong> units</div>
                                            <div class="bill-item d-flex justify-content-between text-white-75">
                                                <span>Slab 1 (0-50)</span>
                                                <strong>₹<%= priceFormat.format(slab1 != null ? slab1 : 0) %></strong>
                                            </div>
                                            <div class="bill-item d-flex justify-content-between text-white-75">
                                                <span>Slab 2 (51-150)</span>
                                                <strong>₹<%= priceFormat.format(slab2 != null ? slab2 : 0) %></strong>
                                            </div>
                                            <div class="bill-item d-flex justify-content-between text-white-75">
                                                <span>Slab 3 (151-250)</span>
                                                <strong>₹<%= priceFormat.format(slab3 != null ? slab3 : 0) %></strong>
                                            </div>
                                            <div class="bill-item d-flex justify-content-between text-white-75">
                                                <span>Slab 4 (251+)</span>
                                                <strong>₹<%= priceFormat.format(slab4 != null ? slab4 : 0) %></strong>
                                            </div>
                                            <div class="bill-item d-flex justify-content-between text-white fw-bold">
                                                <span>Total Payable</span>
                                                <strong>₹<%= priceFormat.format(total) %></strong>
                                            </div>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
    (function () {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();

    $(document).ready(function () {
        $('form').on('submit', function () {
            $('button[type=submit]').prop('disabled', true).text('Calculating...');
        });
    });
</script>
</body>
</html>
