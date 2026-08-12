package com.example.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.DecimalFormat;

@WebServlet(name = "ElectricityBillServlet", urlPatterns = {"/calculate"})
public class ElectricityBillServlet extends HttpServlet {

    private static final DecimalFormat PRICE_FORMAT = new DecimalFormat("0.00");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String input = request.getParameter("units");
        String message = null;
        double total = 0;
        double slab1 = 0, slab2 = 0, slab3 = 0, slab4 = 0;
        int units = 0;

        try {
            units = Integer.parseInt(input.trim());
            if (units < 0) {
                throw new NumberFormatException();
            }

            int remaining = units;
            if (remaining > 0) {
                int slab1Units = Math.min(remaining, 50);
                slab1 = slab1Units * 3.50;
                remaining -= slab1Units;
            }
            if (remaining > 0) {
                int slab2Units = Math.min(remaining, 100);
                slab2 = slab2Units * 4.00;
                remaining -= slab2Units;
            }
            if (remaining > 0) {
                int slab3Units = Math.min(remaining, 100);
                slab3 = slab3Units * 5.20;
                remaining -= slab3Units;
            }
            if (remaining > 0) {
                slab4 = remaining * 6.50;
            }

            total = slab1 + slab2 + slab3 + slab4;
            message = "Electricity bill calculated successfully.";
        } catch (Exception ex) {
            message = "Please enter a valid non-negative number of units.";
            total = -1;
        }

        request.setAttribute("units", units);
        request.setAttribute("total", total);
        request.setAttribute("slab1", slab1);
        request.setAttribute("slab2", slab2);
        request.setAttribute("slab3", slab3);
        request.setAttribute("slab4", slab4);
        request.setAttribute("message", message);
        request.setAttribute("priceFormat", PRICE_FORMAT);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
