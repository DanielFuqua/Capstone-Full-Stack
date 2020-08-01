import React, { useState, useContext } from "react";
import { UserProfileContext } from "../providers/UserProfileProvider";

export const BenefitContext = React.createContext();

export const BenefitProvider = (props) => {

    const [benefits, setBenefits] = useState([]);

    const { getToken } = useContext(UserProfileContext);

    const getBenefitsByPoseId = (id) =>
        getToken().then((token) =>
            fetch(`/api/benefit/${id}`, {
                method: "GET",
                headers: {
                    Authorization: `Bearer ${token}`,
                },
            }).then((res) => res.json()).then(setBenefits));

    return (
        <BenefitContext.Provider value={{ benefits, getBenefitsByPoseId }}>
            {props.children}
        </BenefitContext.Provider>
    );
};