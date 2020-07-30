import React from 'react';
import logo from './logo.svg';
import { BrowserRouter as Router } from "react-router-dom";
import { UserProfileProvider } from "./providers/UserProfileProvider";
import ApplicationViews from "./components/ApplicationViews";


function App() {
  return (
    <Router>
      <UserProfileProvider>
        <ApplicationViews />
      </UserProfileProvider>
    </Router>
  );
}

export default App;
