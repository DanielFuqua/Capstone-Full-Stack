import React, { useState, useContext } from "react";
import { NavLink as RRNavLink } from "react-router-dom";
import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  NavLink,
  UncontrolledDropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem,
} from "reactstrap";
import { UserProfileContext } from "../providers/UserProfileProvider";
import "../App.css";

export default function Header() {
  const { isLoggedIn, logout } = useContext(UserProfileContext);
  const [isOpen, setIsOpen] = useState(false);
  const toggle = () => setIsOpen(!isOpen);
  const userProfile = JSON.parse(sessionStorage.getItem("userProfile"));

  return (
    <div>
      <Navbar color="light" light expand="md">
        <NavbarBrand className="nav_brand" tag={RRNavLink} to="/">
          Asana 26
        </NavbarBrand>
        <NavbarToggler onClick={toggle} />
        <Collapse isOpen={isOpen} navbar>
          <Nav className="mr-auto" navbar>
            {/* When isLoggedIn === true, we will render the Post link */}
            {isLoggedIn && (
              <>
                <NavItem>
                  <NavLink tag={RRNavLink} to="/">
                    Postures
                  </NavLink>
                </NavItem>
              </>
            )}
          </Nav>

          <Nav navbar>
            {isLoggedIn && (
              <>
                {/* <NavItem>
                  Hello {userProfile.displayName}!
              </NavItem>
                <NavItem>
                  <a
                    aria-current="page"
                    className="nav-link"
                    style={{ cursor: "pointer" }}
                    onClick={logout}
                  >
                    Logout
                  </a>
                </NavItem> */}
                <UncontrolledDropdown setActiveFromChild>
                  <DropdownToggle tag="a" className="nav-link" caret>
                    {userProfile.displayName}
                  </DropdownToggle>
                  <DropdownMenu>
                    <DropdownItem onClick={logout} tag="a" active>Logout</DropdownItem>
                  </DropdownMenu>
                </UncontrolledDropdown>
              </>
            )}
            {!isLoggedIn && (
              <>
                <NavItem>
                  <NavLink tag={RRNavLink} to="/login">
                    Login
                  </NavLink>
                </NavItem>
                <NavItem>
                  <NavLink tag={RRNavLink} to="/register">
                    Register
                  </NavLink>
                </NavItem>
              </>
            )}
          </Nav>
        </Collapse>
      </Navbar>
    </div>
  );
}