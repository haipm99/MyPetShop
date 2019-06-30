/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package haipm.pet_controller;

import haipm.dtos.PetDTO;
import haipm.error_obj.ErrorPet;
import haipm.models.ProcessPet;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author 99hai
 */
public class UpdatePetController extends HttpServlet {

    private static final String SUCCESS = "LoadPetController";
    private static final String ERROR = "error.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        ErrorPet err = new ErrorPet();
        boolean valid = true;
        String petID = "";
        try {
            petID = request.getParameter("txtPetID");
            String petName = request.getParameter("txtPetName");
            String petImage = request.getParameter("txtPetImage");
            int petAge = Integer.parseInt(request.getParameter("txtPetAge"));
            if (petAge <= 0) {
                err.setErrorAge("Can't Negative or 0 number.");
                valid = false;
            }
            if (valid) {
                ProcessPet bean = new ProcessPet();
                bean.setPetID(petID);
                if(petImage.length() == 0){
                    petImage = bean.finByPK().getPetImage();
                }
                PetDTO pet = new PetDTO(petID, petName, petImage, petAge);
                bean.setPet(pet);
                valid = bean.updatePet();
                if (valid) {
                    url = SUCCESS;
                } else {
                    url = ERROR;
                    request.setAttribute("ERROR", "Update Falied");
                }
            } else {
                url = "EditPetController?txtPetID=" + petID;
                request.setAttribute("ERROR_PET", err);
            }
        } catch (Exception e) {
            log("Error at UpdatePetController : " + e.getMessage());
            if (e.getMessage().contains("For input string:")) {
                err.setErrorAge("Must be number");
                valid = false;
                url = "EditPetController?txtPetID=" + petID;
                request.setAttribute("ERROR_PET", err);
            }
        } finally {
            if (valid) {
                response.sendRedirect(url);
            } else {
                request.getRequestDispatcher(url).forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
