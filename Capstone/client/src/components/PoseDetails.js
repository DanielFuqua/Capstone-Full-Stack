import React, { useEffect, useContext, useState } from "react";
import { useParams } from "react-router-dom";
import { PoseContext } from "../providers/PoseProvider";
import { InstructionContext } from "../providers/InstructionProvider";
import { BenefitContext } from "../providers/BenefitProvider";
import { ListGroup, ListGroupItem, CardTitle, CardSubtitle, Card, CardImg, CardBody, CardText, Button } from "reactstrap";

const PoseDetails = () => {

    const { id } = useParams();
    const [pose, setPose] = useState({});
    const { getPoseById } = useContext(PoseContext);
    const { instructions, getInstructionsByPoseId } = useContext(InstructionContext);
    const { benefits, getBenefitsByPoseId } = useContext(BenefitContext);

    useEffect(() => {
        getPoseById(parseInt(id)).then((pose) => {
            setPose(pose);
        });
        getInstructionsByPoseId(parseInt(id));
        getBenefitsByPoseId(parseInt(id));
    }, []);


    return (
        <>
                <div className="pose_details_container">
                <Card sm="4">
                    <CardTitle className="text-center"><h1>{pose.nameEnglish}</h1></CardTitle>
                    <CardSubtitle className="text-center"><h2>{pose.nameSanskrit}</h2></CardSubtitle>
                    <CardImg src={pose.imageLocation} alt={pose.nameEnglish} />
                    <CardBody>
                        <div>
                            <h2 className="text-center">Instructions:</h2>
                            <ol>
                                {instructions.map((inst) => <li>{inst.content}</li>)}
                            </ol>

                        </div>

                        <div>
                            <h2 className="text-center">Benefits:</h2>
                            <ul>
                                {benefits.map((ben) => <li>{ben.content}</li>)}
                            </ul>
                           
                        </div>
                    </CardBody>
                </Card>
                </div>
        </>
    );
};
export default PoseDetails;