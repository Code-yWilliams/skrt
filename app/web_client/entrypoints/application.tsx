import { createRoot } from "react-dom/client";

// import CssBaseline from '@mui/material/CssBaseline';
// import { ThemeProvider } from '@mui/material/styles';
import App from "../App";
import React from "react";

// import theme from './theme';

const rootElement = document.getElementById("root")!;
const root = createRoot(rootElement);

root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
