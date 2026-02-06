// import PDFDocument from "pdfkit";
// import { getAllPostsReport } from "./adminPostReport.controller.js";

// export const downloadPostsPdf = async (req, res) => {
//   console.log("hiiii");
  
//   try {
//     const fakeRes = {
//       json(data) {
//         this.data = data;
//       },
//     };

//     await getAllPostsReport(req, fakeRes);
//     const posts = fakeRes.data;

//     const doc = new PDFDocument({ margin: 30, size: "A4" });

//     res.setHeader("Content-Type", "application/pdf");
//     res.setHeader(
//       "Content-Disposition",
//       "attachment; filename=hairfidence-post-report.pdf"
//     );

//     doc.pipe(res);

//     doc.fontSize(18).text("Hairfidence – Post Status Report", {
//       align: "center",
//     });

//     doc.moveDown();

//     posts.forEach((p, i) => {
//       doc
//         .fontSize(11)
//         .text(
//           `${i + 1}. [${p.postType}] ${p.ownerName}
// Hair: ${p.hairLength}cm | ${p.hairType} | ${p.hairColor}
// Qty: ${p.quantity} | Location: ${p.location}
// Status: ${p.status}
// Date: ${new Date(p.createdAt).toDateString()}
// ----------------------------`
//         );
//       doc.moveDown(0.5);
//     });

//     doc.end();
//   } catch (err) {
//     console.error("PDF Error:", err);
//     res.status(500).json({ message: "Failed to generate PDF" });
//   }
// };


import PDFDocument from "pdfkit";
import { getAllPostsReport } from "./adminPostReport.controller.js";

export const downloadPostsPdf = async (req, res) => {
  console.log("hiii");
  
  try {
    // capture JSON response
    const fakeRes = {
      json(data) {
        this.data = data;
      },
    };

    await getAllPostsReport(req, fakeRes);
    const posts = fakeRes.data || [];

    const doc = new PDFDocument({ margin: 30, size: "A4" });

    res.setHeader("Content-Type", "application/pdf");
    res.setHeader(
      "Content-Disposition",
      "attachment; filename=hairfidence-post-report.pdf"
    );

    doc.pipe(res);

    doc
      .fontSize(18)
      .text("Hairfidence – Post Status Report", { align: "center" });

    doc.moveDown();
    doc.fontSize(10).text(`Generated On: ${new Date().toDateString()}`);
    doc.moveDown();

    posts.forEach((p, i) => {
      doc.text(
        `${i + 1}. [${p.postType}]
Owner: ${p.ownerName}
Hair: ${p.hairLength}cm | ${p.hairType} | ${p.hairColor}
Qty: ${p.quantity}
Location: ${p.location}
Status: ${p.status}
Date: ${new Date(p.createdAt).toDateString()}
--------------------------------------------`
      );
      doc.moveDown(0.5);
    });

    doc.end();
  } catch (err) {
    console.error("PDF Error:", err);
    res.status(500).json({ message: "Failed to generate PDF" });
  }
};
